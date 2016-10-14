module Bot
  module DiscordCommands
    # Add tracker of playling now on channel.
    # Can only be stopped by restarting bot or `mcstop`.
    module MCTrack
      loops = {}
      extend Discordrb::Commands::CommandContainer
      command(:mctrack, permission_level: 1) do |event|
        break if loops[event.channel.id]
        title = ''
        loops[event.channel.id] = true
        while loops[event.channel.id]
          page = Nokogiri::HTML(open('https://www.mctl.gq/',
                                     ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
          if title != page.css('span#title').text
            event.respond "__**Monstercat FM**__
            Now playing: **#{page.css('span#title').text}**
            by ***#{page.css('span#artists').text}***
            Album: **#{page.css('span#album').text}**
            #{page.css('img#np-image')[0]['src']}"
            title = page.css('span#title').text
            sleep 180
          end
          sleep 20
          break unless loops[event.channel.id]
        end
      end
      command(:mcstop, permission_level: 1) do |event|
        loops[event.channel.id] = false
        m = event.respond 'Stop!'
        sleep 3
        m.delete
      end
    end
  end
end
