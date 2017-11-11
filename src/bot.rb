# Gems
require 'bundler/setup'
require 'discordrb'
require 'json'
# require 'mini_magick'
require 'nokogiri'
require 'open-uri'
require 'yaml'
require 'yourub'

# The main bot module.
module Bot
  # Load non-Discordrb modules
  Dir['src/modules/*.rb'].each { |mod| load mod }

  # Bot configuration
  CONFIG = OpenStruct.new YAML.load_file 'data/config.yml'

  # Create the bot.
  # The bot is created as a constant, so that you
  # can access the cache anywhere.
  BOT = Discordrb::Commands::CommandBot.new(
    token: CONFIG.token,
    prefix: CONFIG.prefix,
    webhook_commands: false,
    ignore_bots: true
  )

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

  # Owner permission
  BOT.set_user_permission(CONFIG.owner, 999)

  # Bot buckets
  BOT.bucket :limit, limit: 10, time_span: 1000, delay: 60

  # Youtube client
  options = { developer_key: CONFIG.youtube_key,
              application_name: 'yourub',
              application_version: 2.0,
              log_level: 3 }
  YT_CLIENT = Yourub::Client.new(options)

  # Run the bot
  BOT.run
end
