#encoding: utf-8
require 'cinch'
Dir["./plugins/*.rb"].each { |file| require_relative file }


bot = Cinch::Bot.new do
  configure do |c|
    c.nick = 'DoziARM'
    c.user = 'dozorce'
    c.server = "irc.rizon.net"
    c.channels = ['#soulwell']
    c.encoding = 'UTF-8'
    c.plugins.plugins = [
        Bash,
        Calculator,
        Csfd,
        Google,
        Help,
        Rejoin,
        Rss,
        Title,
        Translator,
        Twitter,
        Wiki,
        Youtube]
    c.plugins.prefix = ''
  end
end

Calculator.configure do |c|
  c.currency_shortcut = {
      :to   => 'czk',
      :from => %w(usd eur euro euros),
      :symbols => {
          :usd   => '$',
          :eur   => '€',
          :pound => '£'
      }
  }
end

Rss.configure do |c|
  c.feeds = {
      :AppSales        => 'http://feeds.feedburner.com/AppsalesRss?format=xml',
      :bashoid         => 'https://github.com/Audio/bashoid/commits/master.atom',
      :dozorce         => 'https://github.com/Audio/dozorce/commits/master.atom',
      :DotaTimer       => 'https://github.com/Frca/DotaTimer/commits/master.atom',
      :fIRC            => 'https://github.com/Frca/fIRC/commits/master.atom',
      :Lorris          => 'https://github.com/Tasssadar/Lorris/commits/master.atom',
      :"Lorris mobile" => 'https://github.com/Tasssadar/lorris_mobile/commits/master.atom',
      :MaNGOS          => 'https://github.com/mangos/server/commits/master.atom',
      :soulcore        => 'http://soulwell.czechdream.cz/rss_git.php?parameters=p%3Dsoulcore.git%3Ba%3Datom',
      :Steam           => 'http://api.twitter.com/1/statuses/user_timeline.rss?screen_name=steam_games',
      :TrinityCore     => 'https://github.com/TrinityCore/TrinityCore/commits/master.atom',
      :Wine            => 'http://www.winehq.org/news/rss/'
  }
end

bot.loggers.level = :warn
bot.start
