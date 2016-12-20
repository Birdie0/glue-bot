module Bot
  module DiscordCommands
    # Convert music request from pre-generated playlists.
    # Max 6 songs for one request.
    module Add
      extend Discordrb::Commands::CommandContainer
      command(:add, description: "Add list of tracks in Mee6's command style!", usage: '+add song1, http://link2.com, etc.', bucket: :limit) do |event, *args|
        args = args.join(' ').split(',')
        break unless args.length <= 6
        # event.respond "#{args.length} tracks added by **#{event.user.name}**"
        args.each do |i|
          event.send_temp("!add #{i}", 1)
          sleep 2
        end
        nil
      end
    end
  end
end
