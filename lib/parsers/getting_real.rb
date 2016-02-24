require 'mechanize'

module Parsers
  class GettingReal
    INDEX = "http://gettingreal.37signals.com/thanks.php"
    SOURCE = "Getting Real"
    AUTHOR = "David"

    def parse(&callback)
      urls.each do |url|
        callback.call(document(url))
      end
    end

    private

    def urls
      agent.get(INDEX).search('//li/a/@href').map(&:value)
    end

    def document(url)
      page = agent.get(url)

      return { 
        title: page.search('h1'),
        content: page.search('//div[@class="content"]/h1/following-sibling::*[not(@class="next")]').text.strip,
        author: AUTHOR,
        source: SOURCE,
        url: page.uri,
        published_on: nil
      }
    end

    def agent
      @agent ||= Mechanize.new
    end
  end
end
