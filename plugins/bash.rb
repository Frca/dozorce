require_relative '../utils/webpage'


class Bash
  include Cinch::Plugin

  set :help, 'bash - prints a random quote from bash.org database'

  match /bash$/

  def execute(m)
    quote = take_one( download_parse )
    quote.content.each { |line| m.reply(line) }
    m.reply("-- http://bash.org/?#{quote.id} --")
  end

  def download_parse
    page = WebPage.load_html('http://bash.org/?random1')
    quotes = BashParser.get_quotes(page)
    quotes.sort!.reverse!
    quotes = quotes[0..9]
    quotes.shuffle!
  end

  def take_one(quotes)
    max_lines_limit = 6
    quotes.each { |q| return q if q.line_count <= max_lines_limit }
    quotes[0]
  end
 end

class BashQuote
  include Comparable
  attr_reader :id, :content, :score

  def initialize(id, content, score)
    @id, @content, @score = id, content, score
  end

  def line_count
    @content.size
  end

  def <=>(other)
    @score <=> other.score
  end
end

class BashParser
  def self.get_quotes(page)
    quotes = []
    headers = page.xpath("//p[@class='quote']")
    bodies = page.xpath("//p[@class='qt']")

    headers.size.times { |i|
      body = bodies[i].text.split(/\r?\n/)
      header = headers[i]

      id = header.text.strip[1..-1].to_i
      score = header.xpath('./text()').to_s.strip[1..-2].to_i
      quotes << BashQuote.new(id, body, score)
    }

    quotes
  end
end
