# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Searches songs into chosen playlist.
    module Search
      extend Discordrb::Commands::CommandContainer

      command(:search,
              min_args: 2,
              description: 'Searches query into chosen playlist.',
              usage: "#{BOT.prefix}search <playlist> <query>") do |event, name, *query|
        name.downcase!
        if File.exist?("config/playlists/#{name}.json")
          query = query.join(' ').downcase
          list = Oj.load_file("config/playlists/#{name}.json")['songs'].values.select { |i| i.downcase.include? query }
          event << '```md'
          if list.empty?
            event << '# No results...'
          else
            event << "# #{name} playlist | query: #{query} | first 20 results"
            list.first(20).each { |i| event << "* #{i.chomp}" }
          end
          event << '```'
        else
          event << "#{name} playlist is not exist!"
          event << "Type `#{BOT.prefix}list` for playlists list!"
        end
      end

    end
  end
end
