module Bot
  module DiscordCommands
    # Send picture with easy-to-learn Markdown basics.
    module SofterWorld
      extend Discordrb::Commands::CommandContainer
      command :asw do |event|
        page = Nokogiri::HTML(open("http://www.asofterworld.com/index.php?id=#{rand(1..1248)}", ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
        event << '__**' + page.css('div#comicimg img')[0]['title'] + '**__'
        event << page.css('div#comicimg img')[0]['src']
      end
    end
  end
end
