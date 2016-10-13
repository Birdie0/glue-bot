## glue-bot

This is bot for Discord with some nice features! The base idea of creation of bot is making easy multi-add function for [Mee6 bot](http://mee6.xyz) and tracking music from *Monstercat FM*.
It can work with other bots but I not guarantee it. Many features been here such a spam, message animation and others but stays the most stabile and less ratelimit causing. They are back. Maybe... It distant future...

List of commands:
  * _Info_ - some basic info
    * `about` - info about bot;
    * `markdown` - show you basics of Markdown;
    * `github` - gives link to this repository.
    * 
  * _Mee6_
    * `add` - add list of tracks in Mee6's command style!;
    * `custom` - add track to *custom* playlist;
    * `list` - show avaliable playlists;
    * `show` - add list of random tracks from your playlist in custom command style! (Probably not work but you can try...);
  * _Monstercat_
    * `mcnow` - return name of track, artist, album and album cover of song playing now on [Monstercat FM](https://twitch.tv/monstercat)
    * `mctrack` - same as above but self update when song is changed;
    * `nocat` - stop the looping;
  * _Secret (kinda)_
    * `eval` - no comments, dangerous...
    * `restart` - turn off bot... But using `run.sh` for launching restart bot.

## Requirements:
* Ruby 2.3.x+
* Computer
* Internet

## Installation:
  1. Download or clone current repository.
  2. Rename in `data` folder `config-example.yaml` to `config.yaml`.
  3. Replace `token`, `clientid`, `prefix` and `owner_id` to yours.
  4. Run `bundle install`.
  5. Run in terminal `./run.sh` or `ruby run.rb`.

## Problems:
  * Can't launch `run.sh`
    * Run in terminal `chmod +x run.sh`.

  * `bundle install` don't work.
    * Run in terminal `gem install bundler` or `gem i bundler`

## Questions:
  * With questions and suggestions please come here -> [Discord](https://discord.gg/eJcMYph)

## Additional links:
 * http://mee6.xyz/ - Cool bot
 * https://www.mctl.gq/ - Parse info about now playing from here
 * https://twitch.tv/monstercat - Monstercat Twitch channel
 * https://github.com/z64/gemstone - bot was rewrited using this template. 
