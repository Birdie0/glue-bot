module Bot
  module DiscordCommands
    # Whitelists user.
    module Whitelist
      extend Discordrb::Commands::CommandContainer
      command(:whitelist,
              help_available: false,
              description: 'Whitelists chosen member.',
              usage: "#{BOT.prefix}whitelist <+/-> <id>") do |event, id, x = '+'|
        break unless event.user.id == CONFIG.owner
        list = File.readlines('data/whitelist.txt').map(&:chomp)
        case x
        when '+'
          if list.include? id
            event << 'That user is whitelisted already!'
          else
            open('data/whitelist.txt', 'a') { |f| f.puts id }
            BOT.set_user_permission(id, 10)
            event << "Welcome to the club, <@#{id}>!"
          end
        when '-'
          if !list.include? id
            event << 'Can\'t find that user in the whitelist!'
          else
            list -= [id]
            open('data/whitelist.txt', 'w') { |f| f.puts list }
            BOT.set_user_permission(id, 0)
            event << "Bye bye, <@#{id}>!"
          end
        end
      end
    end
  end
end
