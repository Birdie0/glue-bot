# glue-bot

## List of commands

* Info
  * `about` - some info about bot
  * `markdown` - Markdown tutorial
  * `invite` - invite bot link
  * `ping` - responds with "Pong!"
  * `help` - commands list

* Playlist manager
  * `add` - adds a track to playlist
  * `remove` - removed a track from playlist
  * `create` - creates empty playlist
  * `list` - shows playlists
  * `search` - searches songs in a playlist by name
  * `show` - shows a list of tracks from playlist
  * `play` - adds tracks to playlist of pther bot with custom prefix! Works with Mee6 and MusicBot (Add bot id to DJs)
  * `export` - generates .txt with links for exporting to MusicBot

* Monstercat
  * `mcnow` - shows track info of current playing song on Monstercat's Twitch stream

* Comics
  * `xkcd` - shows random [xkcd](http://xkcd.com/) comic
  * `asw` - shows random [a Softer World](http://www.asofterworld.com/) comic
  * `nedr` - shows random [Nedroid](http://nedroid.com/) comic

* Pictures
  * `shibe` - shows random shibe
  * `cat` - shows random cat
  * `bird` - shows random bird

* Mee6
  * `mshard` - calculates Mee6 shard by server id
  * `meelead` - shows top 12 in Mee6's leaderboard for current server

* IFTTT
  * `setkey` - save maker key to storage
  * `delkey` - remove maker key from storage
  * `seturl` - same but with webhooks url
  * `delurl` - same but with webhooks url
  * `send` - send request using maker key to IFTTT, so you can now use Discord command as trigger
  * `webhook` - same but for webhooks
  * `jbeauty` - lint + beautify json body

* Non public
  * `eval` - eval command, meh...
  * `restart` - turns off your bot. Run bot in loop (`rake runme`) to make it restart

## [Invite the bot](https://discordapp.com/oauth2/authorize?&client_id=182241887703269376&scope=bot)

## Hosting

### Requirements

* Ruby 2.3.x+
* Redis

### Installation & running the bot

1. Download or clone the current repository
1. Copy `data-template` folder and rename it to `data`
1. Fill down with needed values
1. Run `rake runme` in a terminal

### Updating

Bot updates with every reboot, but can be run with `rake update` command

## Questions

If you have any questions or suggestions, please come on my [Discord server](https://discord.gg/eJcMYph)

## Additional links

### Bots

* [Mee6](https://mee6.xyz)
* [MusicBot](https://github.com/Just-Some-Bots/MusicBot)

### Monstercat

* [Monstercat Tracklist](https://mctl.io/)
* [Twitch channel](https://www.twitch.tv/monstercat)

### Comics

* [Xkcd](https://xkcd.com) by Randall Munroe
* [A Softer World](http://www.asofterworld.com) by Joey Comeau and Emily Horne
* [Nedroid](http://nedroid.com) by Anthony Clar

### APIs

* [shibe.online](http://shibe.online) - source of shibe, cat and bird pics

### Websites

* [IFTTT](https://ifttt.com) - free web-based service to create chains of simple conditional statements, called applets

### Template

* [gemstone](https://github.com/z64/gemstone) - bot was rewrited using this template
