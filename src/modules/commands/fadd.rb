module Bot
  module DiscordCommands
    # Add music request from pre-generated playlists.
    # Max 6 songs for one request.
    module FAdd
      extend Discordrb::Commands::CommandContainer
      command(:fadd, description: "Add list of tracks in Flamingo's command style!", bucket: :limit) do |event, *args|
        args = args.join(' ').split(',')
        break unless args.length <= 6
        # event.respond "#{args.length} tracks added by **#{event.user.name}**"
        args.each do |i|
          event.send_temp("f!add #{i}", 1)
          sleep 2
        end
        nil
      end
    end
  end
end
