# glue-bot

This is a bot for Discord with some nice features! The basic idea of the creation of this bot is making an easy multi-add function for the [Mee6 bot](http://mee6.xyz), [Flamingo](https://flambot.xyz), other music bots(?) and tracking music from *Monstercat FM*.
It can work with other bots but I do not guarantee it. Many features have been here such a spam, message animation and others but stays the most stabile and less ratelimit causing. They are back. Maybe... In a distant future...

## List of commands

* *Info*
  * `about` - basic info about bot
  * `markdown` - Markdown tutorial
  * `invite` - gives invite to support server

* *Mee6*
  * `addto` - adds a track to chosen playlist
  * `list` - shows available playlists
  * `play` - adds a list of random tracks from your playlist in Mee6's command style!
  * `show` - shows a list of random tracks from chosen playlist
  * `create` - creates empty playlist
  * `search` - search songs in playlist by name
  * `export` - generates .txt with links for Exporting to RhinoBot

* *Monstercat*
  * `mcnow` - shows name of track, artist, album and album cover of song playing now on [Monstercat FM](https://twitch.tv/monstercat)

* *Comics*
  * `xkcd` - shows random comic from [xkcd](http://xkcd.com/)
  * `asw` - shows random comic from [a Softer World](http://www.asofterworld.com/)
  * `nedr` - shows random comic from [Nedroid](http://nedroid.com/)

* *Secret (kinda)*
  * `eval` - eval command, very dangerous...
  * `restart` - turns off your bot. If you launch bot with `./run.sh` it's will restarts
  * `ping` - Responds with "Pong!" with ping

## [Invite the bot](https://discordapp.com/oauth2/authorize?&client_id=182241887703269376&scope=bot)

## Hosting

### Requirements

* Ruby 2.3.x+
* Computer
* Internet
* `bundler` gem

### Installation

1. Download or clone the current repository
1. Rename `data-template` folder to `data`
1. Replace `token`, `prefix` and `owner_id` to yours
1. Run `rake runme` in a terminal

### Updating

Bot updates with every reboot but if you want you can make **hard** reboot

1. Stop the bot
1. Run `./update.sh` for **hard** update

### Problems

* Can't launch `run.sh`
  * Run `chmod +x run.sh` in a terminal
* `bundle install` doesn't work
  * Run `gem install bundler` or `gem i bundler` in a terminal

## Questions

If you have any questions or suggestions, please come on my [Discord server](https://discord.gg/eJcMYph)

## Additional links

### Bots

* [Mee6](https://mee6.xyz)
* [Flamingo](https://flambot.xyz)
* [RhinoBot](https://github.com/Just-Some-Bots/MusicBot)

### Monstercat

* [Monstercat Tracklist](https://www.mctl.gq)
* [Twitch channel](https://twitch.tv/monstercat)

### Comics

* [Xkcd](https://xkcd.com) by Randall Munroe
* [A Softer World](http://www.asofterworld.com) by Joey Comeau and Emily Horne
* [Nedroid](http://nedroid.com) by Anthony Clar

### Template

* [gemstone](https://github.com/z64/gemstone) - bot was rewrited using this template
