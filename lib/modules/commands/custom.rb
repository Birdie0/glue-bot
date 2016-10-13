module Bot
  module DiscordCommands
    # Add music names to **custom** playlist.
    module Custom
      extend Discordrb::Commands::CommandContainer
      command(:custom, min_args: 1) do |event, *args|
        f = File.new('playlists/custom.txt', 'a')
        f.puts(args.join(' '))
        f.close
        event.message.delete
        m = event.respond "__*#{args.join(' ')}*__ was added to custom playlist!"
        sleep 3
        m.delete
      end
    end
  end
end
