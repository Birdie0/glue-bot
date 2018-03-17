module Bot
  module DiscordCommands
    # Exports playlist to txt file.
    module Export
      extend Discordrb::Commands::CommandContainer

      command(:export,
              min_args: 1,
              description: 'Exports playlist to txt file.',
              usage: "#{BOT.prefix}export <playlist>") do |event, name|
        name.downcase!
        if File.exist?("config/playlists/#{name}.json")
          list = Oj.load_file("config/playlists/#{name}.json")['songs']
          x = ''
          list.each_key { |i| x << "https://youtu.be/#{i}\r\n" }
          File.write("#{name}.txt", x)
          event.channel.send_file File.new("#{name}.txt")
          File.delete("#{name}.txt")
        else
          event << "#{name} playlist is not exist!"
          event << "Type `#{BOT.prefix}list` for playlists list!"
        end
        nil
      end

    end
  end
end
