# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Fun commands.
    module Fun
      extend Discordrb::Commands::CommandContainer

      DISHES = [
        'beer',
        'burrito',
        'coffee',
        'croissant',
        'curry',
        'custard',
        'fries',
        'hamburger',
        'hotdog',
        'pancakes',
        'pizza',
        'pizza',
        'ramen',
        'rice',
        'salad',
        'spaghetti',
        'spaghetti',
        'stew',
        'stuffed flatbread',
        'sushi',
        'taco',
        'taco',
        'tea',
        'tropical drink'
      ].freeze

      command(:order,
              # description: 'Info about the bot',
              usage: "#{BOT.prefix}order coffee") do |event, *args|
        name = args.join(' ')
        if DISHES.include?(name.tr(' ', '_'))
          event.send ':ok_hand: One minute, please!'
          SCHEDULER.in '60s' do
            event.send "#{event.user.mention}, here's your #{name}! :#{name}:"
          end
          nil
        else
          event << 'Sorry, I do not know what is that.'
          event << "Use `#{BOT.prefix}suggest` to send your suggestion. :wink:"
        end
      end

      command(:foods,
              # description: 'Info about the bot',
              usage: "#{BOT.prefix}food") do |event|
        event << "```md\nList:"
        event << DISHES.map { |i| "# #{i.tr(' ', '_')}" }.join("\n")
        event << '```'
      end

      FOODS = Oj.load_file('config/foods.json')
      command(:order2) do |event, *dish|
        dish = dish.join(' ').downcase
        food = FOODS['foods'].find { |i| (i['aliases'] + [i['name']]).include?(dish) }
        if food
          event.send ':ok_hand: Uno momento!'
          SCHEDULER.in "#{food['duration']}s" do
            event.send "#{event.user.mention}, here's your #{food['name']}! #{food['emojis'].sample}\n#{food['images'].sample}"
          end
          nil
        else
          event.send "Sorry, I don't know what's this! Check `g.foods2`, maybe you misspelled the name of dish."
        end
      end

      command(:foods2, usage: "#{BOT.prefix}food") do |event|
        event << "```md\nList:"
        event << FOODS['foods'].map { |i| "# #{i['name']}" }.join("\n")
        event << '```'
      end

      command(:foodinfo) do |event, *dish|
        dish = dish.join(' ').downcase
        food = FOODS['foods'].find { |i| (i['aliases'] + [i['name']]).include?(dish) }
        if food
          event.channel.send_embed do |embed|
            embed.color = 0xe8f04d
            embed.title = food['name']
            # embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: food['images'].sample)
            embed.add_field(name: 'Preparation time', value: "#{food['duration']} seconds")
            embed.add_field(name: 'Icon', value: food['emojis'].first)
          end
        else
          event.send "Sorry, I don't know what's this! Check `g.foods2`, maybe you misspelled the name of dish."
        end
      end

      command(:suggest,
              description: "Send suggestions to bot's dev",
              usage: "#{BOT.prefix}suggest cat command",
              min_args: 1) do |event, *args|
        text = args.join(' ')
        BOT.channel(CONFIG.suggestions_channel_id).send_embed do |embed|
          embed.color = rand(0..0xffffff)
          embed.title = 'New suggestion'
          embed.description = text
          embed.author = Discordrb::Webhooks::EmbedAuthor.new(
            name: event.user.name,
            icon_url: event.user.avatar_url
          )
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(
            text: "ID: #{event.user.id}"
          )
          embed.timestamp = Time.now
        end
        event << 'Suggestion sent! Thanks :cookie:'
      end

    end
  end
end
