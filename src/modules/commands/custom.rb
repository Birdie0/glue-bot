module Bot
  module DiscordCommands
    # Add music names to **custom** playlist.
    module Custom
      extend Discordrb::Commands::CommandContainer
      command(:custom, min_args: 1) do |event, *args|
        f = File.new('playlists/custom.txt', 'a')
        f << "#{args.join(' ')}\n"
        f.close
        event.message.delete
        event.send_temp("__*#{args.join(' ')}*__ was added to custom playlist!", 3)
        BOT.send_message(CONFIG.music_list_id, "*`#{args.join(' ')}`* added by **#{event.user.name}**", false, CONFIG.channel_id)
      end
    end
  end
end
