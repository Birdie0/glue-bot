module Bot
  module DiscordCommands
    # Exports playlist to txt file.
    module Export
      extend Discordrb::Commands::CommandContainer
      command(:export,
              min_args: 1,
              description: 'Exports playlist to txt file.',
              usage: "#{BOT.prefix}export <playlist>") do |event, name|
        name = name.downcase
        if !File.exist?("data/playlists/#{name}.json")
          event << "#{name} playlist is not exist!"
          event << "Type `#{BOT.prefix}list` for playlists list!"
        else
          list = JSON.parse(File.read("data/playlists/#{name}.json"))['songs']
          x = ''
          list.keys.each { |i| x << "https://youtu.be/#{i}\n" }
          open("#{name}.txt", 'w') { |f| f << x }
          event.channel.send_file File.new("#{name}.txt")
          File.delete("#{name}.txt")
        end
        nil
      end
    end
  end
end
