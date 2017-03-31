module Bot
  module DiscordCommands
    # Show music names from pre-generated playlists.
    module Show
      extend Discordrb::Commands::CommandContainer
      command(:show,
              min_args: 1,
              description: 'Shows titles from the playlist.',
              usage: "#{BOT.prefix}show <playlist> <page>") do |event, name, n = '1'|
        name.downcase!
        if !File.exist?("data/playlists/#{name}.json")
          event << "#{name} playlist is not exist!"
          event << "Type `#{BOT.prefix}list` for playlists list!"
        else
          n = n.to_i
          list = JSON.parse(File.read("data/playlists/#{name}.json"))['songs']
          n = list.length / 20 + 1 if n > list.length / 20 + 1
          event << '```md'
          event << "# #{name} playlist | page #{n}/#{list.length / 20 + 1}"
          list.values.slice((n - 1) * 20, 20).each { |i| event << "* #{i.chomp}" }
          event << '```'
        end
      end
    end
  end
end
