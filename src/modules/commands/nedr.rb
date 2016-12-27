module Bot
  module DiscordCommands
    # Shows random comic from Nedroid.
    module Nedroid
      extend Discordrb::Commands::CommandContainer
      command :nedr do |event|
        page = Nokogiri::HTML(open('http://nedroid.com/?randomcomic=1'))
        event << '__***' + page.css('div#comic img')[0]['alt'] + '***__'
        event << '**' + page.css('div#comic img')[0]['title'] + '**' if page.css('div#comic img')[0]['title'] != page.css('div#comic img')[0]['alt']
        event << 'http:' + page.css('div#comic img')[0]['src']
      end
    end
  end
end
