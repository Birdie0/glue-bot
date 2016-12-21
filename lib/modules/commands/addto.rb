module Bot
  module DiscordCommands
    # Add music names to **custom** playlist.
    module AddTo
      extend Discordrb::Commands::CommandContainer
      command(:addto, min_args: 2) do |event, *args|
        if !File.exist?("playlists/#{args.first.downcase}.txt")
          event << "#{args.first.downcase} playlist is not exist!"
          event << "Type `#{BOT.prefix}list` for playlists list!"
        elsif %w(custom birdie chillcorner monstercat).include?(args.first.downcase)
          event << "Very funny! You Can't Touch This Playlist!"
        else
          f = File.new("playlists/#{args.first.downcase}.txt", 'a')
          f << "#{args.slice(1,args.length).join(' ')}\n"
          f.close
          event.message.delete
          event.send_temp("__*#{args.slice(1,args.length).join(' ')}*__ was added to #{args.first.downcase} playlist!", 3)
          BOT.send_message(CONFIG.music_list_id, "*`#{args.slice(1,args.length).join(' ')}`* added by **#{event.user.name}** to #{args.first.downcase} playlist", false, CONFIG.channel_id)
        end
      end
    end
  end
end
