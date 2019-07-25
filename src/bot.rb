# frozen_string_literal: true

# Gems
Bundler.require

require 'json'
require 'ostruct'
require 'yaml'

# The main bot module.
module Bot
  # Load non-discordrb modules
  Dir['src/modules/*.rb'].each { |mod| load mod }

  # Bot configuration
  CONFIG = OpenStruct.new YAML.load_file 'config/config.yml'

  # Youtube client
  Yt.configure do |config|
    config.api_key = CONFIG.youtube_key
  end
  VIDS = Yt::Collections::Videos.new

  # Database
  # DB = Sequel.sqlite('config/bot.db')

  # Redis client
  REDIS = Redis.new

  # Rufus scheduler
  SCHEDULER = Rufus::Scheduler.new

  # QnA client
  QNA = QnAMaker::Client.new(
    CONFIG.knowledgebase_id,
    CONFIG.subscription_key
  )

  # Create the bot
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

  Dir['src/modules/test/*.rb'].each { |mod| load mod }
  DiscordCommands.constants.each do |mod|
    BOT.include! DiscordCommands.const_get mod
    # BOT.include! DiscordEvents.const_get mod
  end

  # Owner permission
  BOT.set_user_permission(CONFIG.owner_id, 999)

  # Bot buckets
  BOT.bucket :limit, limit: 10, time_span: 1000, delay: 60

  # Run the bot
  BOT.run
end
