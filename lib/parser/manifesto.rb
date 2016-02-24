require 'mechanize'

module Parser
  class Manifesto
    INDEX = "https://37signals.com/manifesto"
    SOURCE = "37signals Manifesto"

    def urls
      agent.get(INDEX).search('//a[@class="homesignallink"]/@href').map(&:value)
    end

    def document(url)
      page = agent.get(url)

      return { 
        title: page.search('span.head').text.strip,
        content: page.search('span.body').first.text.strip,
        author: nil,
        source: SOURCE,
        url: page.uri,
        published_on: nil
      }
    end

    private

    def agent
      @agent ||= Mechanize.new
    end
  end
end
