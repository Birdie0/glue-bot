module Bot
  module DiscordCommands
    # Like `mctrack` post *playing now* only once.
    module MCNow
      extend Discordrb::Commands::CommandContainer
      command :mcnow  do |event|
        page = Nokogiri::HTML(open('https://www.mctl.gq/', ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
        event << '__**Monstercat FM**__'
        event << "Now playing: **#{page.css('span#title').text}**"
        event << "by ***#{page.css('span#artists').text}***"
        event << "Album: **#{page.css('span#album').text}**"
        event << page.css('img#np-image')[0]['src']
      end
    end
  end
end
