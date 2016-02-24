require 'mechanize'

module Parser
  class Archive
    INDEX = "https://signalvnoise.com/archives/"
    SOURCE = "Signal v. Noise Archives: 15 Years of Signal v. Noise"

    def urls
      agent.get(INDEX).search('//section[@class="archives"]//li/a/@href').map(&:value)
    end

    def document(url)
      page = agent.get(url)

      return { 
        title: page.title.sub(' – Signal v. Noise', ''),
        content: page.search('div.post-content').first.text.strip,
        author: page.search('.post-author-bio h2').text.sub('About ', ''),
        source: SOURCE,
        url: page.uri,
        published_on: page.search('.post-date').text.to_date
      }
    end

    private

    def agent
      @agent ||= Mechanize.new
    end
  end
end
