# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Getting animal pics using shibe.online api <3
    module ShibeOnline
      extend Discordrb::Commands::CommandContainer

      # shibe command
      command(:shibe) do |event|
        event.channel.send_embed do |embed|
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTParty.get('http://shibe.online/api/shibes?count=1').parsed_response[0])
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'random shibe from shibe.online')
          embed.color = rand(0..0xFFFFFF)
        end
      end

      # bird command
      command(:cat) do |event|
        event.channel.send_embed do |embed|
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTParty.get('http://shibe.online/api/cats?count=1').parsed_response[0])
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'random cat from shibe.online')
          embed.color = rand(0..0xFFFFFF)
        end
      end

      # bird command
      command(:bird) do |event|
        event.channel.send_embed do |embed|
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTParty.get('http://shibe.online/api/birds?count=1').parsed_response[0])
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'random bird from shibe.online')
          embed.color = rand(0..0xFFFFFF)
        end
      end

    end
  end
end
