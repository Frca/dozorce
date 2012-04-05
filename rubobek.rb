$LOAD_PATH << 'lib' << 'plugins'

require 'cinch'
require 'die'


bot = Cinch::Bot.new do
    configure do |c|
        c.nick = 'rubobek'
        c.user = 'franta'
        c.server = "irc.rizon.net"
        c.channels = ["#abraka"]
        c.plugins.plugins = [Die]
    end
end

bot.start
