module Bot
  module DiscordCommands
    # Add music request from pre-generated playlists.
    # Max 6 songs for one request.
    module Radio
      extend Discordrb::Commands::CommandContainer
      command :radio do |event, link|
        event.respond "!add #{open(link) { |f| f.read.chomp }}"
      end
    end
  end
end
