require 'mechanize'

module Parsers
  class Manifesto
    INDEX = "https://37signals.com/manifesto"
    SOURCE = "37signals Manifesto"

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
        title: page.search('h1').text,
        content: page.search('span.body').first.text.strip,
        author: nil,
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
