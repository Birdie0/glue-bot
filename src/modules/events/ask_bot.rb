module Bot
  module DiscordEvents
    # QNA module
    module AskBot
      extend Discordrb::EventContainer

      color = {
        green: 0x00b159,
        yellow: 0xffc425,
        red: 0x11141
      }

      message(in: CONFIG.ask_channel) do |event|
        message = event.message.content
        answers = QNA.generate_answer(message, 3)
        if answers.first.score.zero? # question not found
          BOT.channel(CONFIG.training_channel).send_embed do |e|
            e.author = Discordrb::Webhooks::EmbedAuthor.new(
              name: event.user.distinct,
              icon_url: event.user.avatar_url
            )
            e.description = message
            e.footer = Discordrb::Webhooks::EmbedFooter.new(
              text: 'answer not found... :('
            )
            e.color = color[:red]
          end
        else
          k = 1
          embed = BOT.channel(CONFIG.training_channel).send_embed do |e|
            e.author = Discordrb::Webhooks::EmbedAuthor.new(
              name: event.user.distinct,
              icon_url: event.user.avatar_url
            )
            e.description = message
            answers.each do |i|
              e.add_field(
                name: "[#{k}] Score: #{i.score}",
                value: i.answer.to_s
              )
              k += 1
            end
            e.footer = Discordrb::Webhooks::EmbedFooter.new(
              text: 'react the correct answer'
            )
            e.color = color[:yellow]
          end
          REDIS.hmset(
            "qna_#{embed.id}",
            # 'user_id', event.user.id.to_s.last(5),
            'user_question', message
          )
          answers.each_with_index do |a, index|
            REDIS.hmset(
              "qna_#{embed.id}",
              "kb_question_#{index}", a.questions.first,
              "kb_answer_#{index}", a.answer
            )
          end
          event << "#{answers.first.answer} **[#{answers.first.score.round(2)}%]**"
        end
      end

      emojis = %w[1⃣ 2⃣ 3⃣ 4⃣ 5⃣ 6⃣ 7⃣ 8⃣ 9⃣]
      reaction_add do |event|
        if event.channel.id == CONFIG.training_channel
          index = emojis.index(event.emoji.name)
          if index
            info = REDIS.hgetall("qna_#{event.message.id}")
            if info.any?
              status = QNA.train_kb([
                                      rand(1..10_000).to_s,
                                      info['user_question'],
                                      info["kb_question_#{index}"],
                                      info["kb_answer_#{index}"]
                                    ])
              unless status
                event.message.edit('', fields: [
                                     { name: 'Question', value: info["kb_question_#{index}"] },
                                     { name: 'Answer', value: info["kb_answer_#{index}"] }
                                   ], footer: {
                                     text: "Confirmed by #{event.user.distinct} <3",
                                     icon_url: event.user.avatar_url
                                   },
                                       color: color[:green])
              end
              REDIS.del("qna_#{event.message.id}")
              event.message.delete_all_reactions
            end
          end
        end
        nil
      end

    end
  end
end
