module Bot
  module DiscordCommands
    # Github link.
    # Nothing to say.
    module Invite
      extend Discordrb::Commands::CommandContainer
      command :invite do |event|
        event << "Invite link: #{BOT.invite_url}"
        event << 'Support server -> https://discord.gg/eJcMYph'
      end
    end
  end
end
