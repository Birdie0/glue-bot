module Bot
  module DiscordCommands
    # Whitelists user.
    module Whitelist
      extend Discordrb::Commands::CommandContainer
      command(:whitelist, permission_level: 999) do |event, id, x = '+'|
        list = File.readlines('data/whitelist.txt')
        case x
        when '+'
          if list.include? id
            event << 'User already whitelisted!!!'
            break
          end
          open('data/whitelist.txt', 'a') { |f| f.puts id }
          BOT.set_user_permission(id, 10)
          event << "Welcome to the club, <@#{id}>!  :smile:"
        when '-'
          list -= [id]
          open('data/whitelist.txt', 'w') { |f| f.puts list }
          BOT.set_user_permission(id, 0)
          event << "Bye bye, <@#{id}>! :sob:"
        end
      end
    end
  end
end
