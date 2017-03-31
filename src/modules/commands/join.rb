module Bot
  module DiscordCommands
    # Add music request from pre-generated playlists.
    # Max 8 songs for one request.
    module Join
      extend Discordrb::Commands::CommandContainer
      command(:join,
              description: '',
              usage: "#{BOT.prefix}join") do |event|
        channel = event.user.voice_channel
        if channel
          voice_connect(channel)
          event << "Connected to voice channel: #{channel.name}"
        else
          event << 'Join to voice channel first!'
        end
      end
    end
  end
end
