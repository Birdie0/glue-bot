module Bot
  module DiscordCommands
    # Convert music request from pre-generated playlists.
    # Max 6 songs for one request.
    module Addc
      extend Discordrb::Commands::CommandContainer
      command(:addc, description: 'Add list of tracks in custom command style!', bucket: :limit) do |event, prefix, *args|
        args = args.join(' ').split(',')
        break unless args.length <= 6
        # event.respond "#{args.length} tracks added by **#{event.user.name}**"
        args.each do |i|
          event.send_temp("#{prefix} #{i}", 1)
          sleep 2
        end
        nil
      end
    end
  end
end
