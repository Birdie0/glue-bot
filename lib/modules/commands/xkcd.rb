module Bot
  module DiscordCommands
    # Send picture with easy-to-learn Markdown basics.
    module Xkcd
      extend Discordrb::Commands::CommandContainer
      command :xkcd do |event|
        page = Nokogiri::HTML(open('http://c.xkcd.com/random/comic/'))
        event << '__**' + page.css('div#comic img')[0]['title'] + '**__'
        event << 'http:' + page.css('div#comic img')[0]['src']
      end
    end
  end
end
