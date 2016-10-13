# Gems
require 'bundler/setup'
require 'discordrb'
require 'yaml'
require 'open-uri'
require 'nokogiri'

# The main bot module.
module Bot
  # Load non-Discordrb modules
  Dir['lib/modules/*.rb'].each { |mod| load mod }

  # Bot configuration
  CONFIG = Config.new

  # Create the bot.
  # The bot is created as a constant, so that you
  # can access the cache anywhere.
  BOT = Discordrb::Commands::CommandBot.new(client_id: CONFIG.client_id,
                                            token: CONFIG.token,
                                            prefix: CONFIG.prefix)

  # Discord commands
  module DiscordCommands; end
  Dir['lib/modules/commands/*.rb'].each { |mod| load mod }
  DiscordCommands.constants.each do |mod|
    BOT.include! DiscordCommands.const_get mod
  end

  # Discord events
  module DiscordEvents; end
  Dir['lib/modules/events/*.rb'].each { |mod| load mod }
  DiscordEvents.constants.each do |mod|
    BOT.include! DiscordEvents.const_get mod
  end

  # Bot buckets
  BOT.bucket :limit, limit: 3, time_span: 300, delay: 100

  # Bot permission
  BOT.set_user_permission(CONFIG.owner, 1)
  
  # Run the bot
  BOT.run
end
