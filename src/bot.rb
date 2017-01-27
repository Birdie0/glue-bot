# Gems
require 'bundler/setup'
require 'discordrb'
require 'yaml'
require 'open-uri'
require 'nokogiri'
require 'json'

# The main bot module.
module Bot
  # Load non-Discordrb modules
  Dir['src/modules/*.rb'].each { |mod| load mod }

  # Bot configuration
  CONFIG = OpenStruct.new YAML.load_file 'data/config.yaml'

  # Create the bot.
  # The bot is created as a constant, so that you
  # can access the cache anywhere.
  BOT = Discordrb::Commands::CommandBot.new(client_id: CONFIG.client_id,
                                            token: CONFIG.token,
                                            prefix: CONFIG.prefix)

  # Discord commands
  module DiscordCommands; end
  Dir['src/modules/commands/*.rb'].each { |mod| load mod }
  DiscordCommands.constants.each do |mod|
    BOT.include! DiscordCommands.const_get mod
  end

  # Discord events
  module DiscordEvents; end
  Dir['src/modules/events/*.rb'].each { |mod| load mod }
  DiscordEvents.constants.each do |mod|
    BOT.include! DiscordEvents.const_get mod
  end

  # Bot buckets
  BOT.bucket :limit, limit: 10, time_span: 1000, delay: 10

  # User permission
  BOT.set_user_permission(CONFIG.owner, 999)

  # Whitelist
  File.readlines('data/whitelist.txt').each { |i| BOT.set_user_permission(i, 10) }

  # Blacklist
  File.readlines('data/blacklist.txt').each { |i| BOT.ignore_user(i) }

  # Stats
  COMMANDS_USED = 0

  # Run the bot
  BOT.run
end
