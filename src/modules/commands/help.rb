module Bot
  module DiscordCommands
    # Github link.
    # Nothing to say.
    module Help
      extend Discordrb::Commands::CommandContainer
      command :help do |event|
        event << '**Info commands**'
        event << '```md'
        event << '* help - Sends this message in PM/DM'
        event << '* about - Some information about the bot'
        event << '* ping - Sends pong message with ping'
        event << '* github - Link to the Github-page of glue-bot'
        event << '* invite - Link to the Support-server'
        event << '* markdown - Tutorial for markdown'
        event << '```'
        event << '**Playlist commands**'
        event << '```md'
        event << '* create {playlistname} - Creates a new (and public) playlist'
        event << '* addto {playlistname} {songtitle} - Adds the song to the playlist'
        event << '* custom {songtitle} - Adds the song to the Custom playlist'
        event << '* list - Shows a list of all existing Playlists'
        event << '* show {playlistname} - Shows random titles from the playlist'
        event << '* add {songtitle} {songtitle} {...} - Adds up to 6 titles in Mee6 style (!add)'
        event << '* playlist {playlistname} {number of songs to be added} - Adds up to 5 random titles from the playlist in Mee6 Style (!add)'
        event << '* fadd {songtitle} {songtitle} {...} - Adds up to 6 titles in Flamingo style (f!add)'
        event << '* fplaylist {playlistname} {number of songs to be added} - Adds up to 5 random titles from the playlist in Flamingo Style (f!add)'
        event << '```'
        event << '**Monstercat tracker commands**'
        event << '```md'
        event << '* mcnow - Shows information of the currently playing song on Monstercat FM'
        event << '* mctrack - Does the same as mcnow but keeps on showing new information, when a new song starts on Monstercat FM'
        event << '* mcstop - Stops the loop of mctrack'
        event << '```'
        event << '**Comic commands**'
        event << '```md'
        event << '* asw - Sends a random comic from http://www.asofterworld.com'
        event << '* nedr - Sends a random comic from http://nedroid.com'
        event << '* xkcd - Sends a random comic from http://xkcd.com'
        event << '```'
      end
    end
  end
end
