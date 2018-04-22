module Bot
  module DiscordCommands
    # QnA commands
    module Qna
      extend Discordrb::Commands::CommandContainer

      command(:publish, required_roles: [CONFIG.tester_role]) do |event|
        begin
          QNA.publish_kb
          event << 'Success!'
        rescue StandardError => e
          event << e.message
        end
      end

      command(:addq, required_roles: [CONFIG.tester_role]) do |event|
        match = event.message.content.match(/#{BOT.prefix}addq (?<question>.+)\|(?<answer>(.|\n)+)/)
        if match && match['question'] && match['answer']
          if QNA.update_kb(add: [[match['question'].strip, match['answer'].strip]]).nil?
            event << ':ok_hand:'
          end
        else
          event << "Usage: `#{BOT.prefix}addq question? | answer!`"
        end
      end

      command(:remq, required_roles: [CONFIG.tester_role]) do |event|
        match = event.message.content.match(/#{BOT.prefix}remq (?<question>.+)\|(?<answer>(.|\n)+)/)
        if match && match['question'] && match['answer']
          if QNA.update_kb(delete: [[match['question'].strip, match['answer'].strip]]).nil?
            event << ':ok_hand:'
          end
        else
          event << "Usage: `#{BOT.prefix}remq question? | answer!`"
        end
      end

    end
  end
end
