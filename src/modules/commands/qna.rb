module Bot
  module DiscordCommands
    # QnA commands
    module Qna
      extend Discordrb::Commands::CommandContainer

      # command(:ask) do |event, *question|
      #   response = QNA.generate_answer(question.join(' '))
      #   if response.first.score.zero?
      #     BOT.channel(434_804_665_763_495_936).send_embed do |e|
      #       e.author = Discordrb::Webhooks::EmbedAuthor.new(
      #         name: event.user.name,
      #         icon_url: event.user.avatar_url
      #       )
      #       e.description = event.message.content
      #       e.footer = Discordrb::Webhooks::EmbedFooter.new(
      #         text: 'answer not found... :('
      #       )
      #       e.color = rand(0..0xffffff)
      #     end
      #   else
      #     event << '**Possible solutions:**'
      #     k = 1
      #     response.each do |i|
      #       event << "**#{k}. [#{i.score.round(2)}%]**\n#{i.answer}"
      #       k += 1
      #     end
      #     BOT.channel(434_804_665_763_495_936).send_embed do |e|
      #       e.author = Discordrb::Webhooks::EmbedAuthor.new(
      #         name: event.user.name,
      #         icon_url: event.user.avatar_url
      #       )
      #       e.description = event.message.content
      #       e.footer = Discordrb::Webhooks::EmbedFooter.new(
      #         text: 'answer not found... :('
      #       )
      #       e.color = rand(0..0xffffff)
      #     end
      #   end
      #   nil
      # end

      # command(:ask2) do |event, *question|
      #   response = QNA.generate_answer(question.join(' '))
      #   if response.first.score != 0
      #     event.channel.send_embed do |embed|
      #       embed.title = response.first.questions.join(' ')
      #       embed.description = response.map_with_index { |i, index| "**#{index + 1}**. #{i.answer}" }.join("\n")
      #       embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Score: #{i.score}")
      #       embed.color = rand(0..0xffffff)
      #     end
      #   else
      #     'Question not found!'
      #   end
      # end

      # command(:ask2) do |event, *question|
      #   response = QNA.generate_answer(question.join(' '))
      #   if response.first.score != 0
      #     event.channel.send_embed do |embed|
      #       embed.title = response.first.questions.join(' ')
      #       embed.description = response.map_with_index { |i, index| "**#{index + 1}**. #{i.answer}" }.join("\n")
      #       embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Score: #{i.score}")
      #       embed.color = rand(0..0xffffff)
      #     end
      #   else
      #     'Question not found!'
      #   end
      # end

      # command :ask2 do |event, *q|
      #   a = QNA.generate_answer(q.join(' '), 3)
      #   event << a.map { |i| "**1.** #{i.questions.join(' ')}\n#{i.answer}" }.join("\n\n")
      # end

      # command(:addq, required_roles: [193_123_929_701_875_712]) do |event|
      #   match = event.message.content.match(/q: (?<question>(.+))\na: (?<answer>(.|\n)+)/)
      #   if match && match['question'] && match['answer']
      #     QNA.update_kb([answer: match['answer'], question: match['question']])
      #   else
      #     event << "nope! try something like: ```\nq: why something something?\n a: because that!```"
      #   end
      # end

      # command(:train, required_roles: [193_123_929_701_875_712]) do |event|
      #   match = event.message.content.match(/u: (?<question2>(.+))\nq: (?<question>(.+))\na: (?<answer>(.|\n)+)/)
      #   if match && match['question2'] && match['question'] && match['answer']
      #     QNA.train_kb(match['question2'], match['question'], match['answer'])
      #   else
      #     event << "nope! try something like: ```\nu: why?\nq: why something something?\n a: because that!```"
      #   end
      # end

      command(:publish, required_roles: [CONFIG.tester_role_id]) do |event|
        begin
          QNA.publish_kb
          event << 'Success!'
        rescue StandardError => e
          event << e.message
        end
      end

    end
  end
end
