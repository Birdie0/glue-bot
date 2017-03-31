module Bot
  module DiscordCommands
    # Blacklists user.
    module Blacklist
      extend Discordrb::Commands::CommandContainer
      command(:blacklist,
              help_available: false,
              description: 'Blacklists chosen member.',
              usage: "#{BOT.prefix}blacklist <+/-> <id>") do |event, id, x = '+'|
        break unless event.user.id == CONFIG.owner
        list = File.readlines('data/blacklist.txt').map(&:chomp)
        case x
        when '+'
          if list.include? id
            event << 'That user is blacklisted already!'
          else
            open('data/blacklist.txt', 'a') { |f| f.puts id }
            BOT.ignore_user(id)
            event << "I just blocked <@#{id}>!"
          end
        when '-'
          if !list.include? id
            event << 'Can\'t find that user in the blacklist!'
          else
            list -= [id]
            open('data/blacklist.txt', 'w') { |f| f.puts list }
            BOT.unignore_user(id)
            event << "<@#{id}> was unblocked... Friends?"
          end
        end
      end
    end
  end
end
