module Bot
  module DiscordCommands
    # Blacklists user.
    module Blacklist
      extend Discordrb::Commands::CommandContainer
      command(:blacklist, permission_level: 999) do |event, id, x = '+'|
        list = File.readlines('data/blacklist.txt')
        case x
        when '+'
          if list.include? id
            event << 'User already blacklisted!!!'
            break
          end
          open('data/blacklist.txt', 'a') { |f| f.puts id }
          BOT.ignore_user(id)
          event << "Sorry, but I must to do this. You're bad person, <@#{id}>! :angry:"
        when '-'
          list -= [id]
          open('data/blacklist.txt', 'w') { |f| f.puts list }
          BOT.unignore_user(id)
          event << "I forgive you this time... Be nice, <@#{id}>... or you will get grrrr from me next time!!! :rage:"
        end
      end
    end
  end
end
