require 'mechanize'
require 'thread'
require 'thwait'

module Parsers
  class Archive
    INDEX = "https://signalvnoise.com/archives/"
    SOURCE = "Signal v. Noise Archives: 15 Years of Signal v. Noise"

    def parse(&callback)
      produce.each do |url|
        consume(url, callback)
      end
    end

    def produce
      urls
    end

    def consume(url, callback)
      callback.call(document(url))
    end

    private

    def urls
      agent.get(INDEX).search('//section[@class="archives"]//li/a/@href').map(&:value)
    end

    def document(url)
      page = agent.get(url)

      begin
        return { 
          title: page.title.sub(' – Signal v. Noise', ''),
          content: page.search('div.post-content').first.text.strip,
          author: page.search('.post-author-bio h2').text.sub('About ', ''),
          source: SOURCE,
          url: url,
          published_on: page.search('.post-date').text.to_date
        }
      rescue
        byebug
      end
    end

    def agent
      @agent ||= Mechanize.new
    end
  end
end
