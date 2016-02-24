require 'mechanize'

module Parser
  class OlderArchive
    INDEX = "https://signalvnoise.com/older_archives.php"
    SOURCE = "Signal v. Noise Older Archives"

    def urls
      agent.get(INDEX).search('//div[@id="ArchiveList"]//a/@href').map(&:value)
    end

    def document(url)
      page = agent.get(url)

      return { 
        title: page.title.sub(' - Signal vs. Noise (by 37signals)', ''),
        content: page.search('//div[@class="post"]/div[@class="post_header"]/following-sibling::*').text.strip,
        author: page.search('.post_header .author').text,
        source: SOURCE,
        url: page.uri,
        published_on: page.search('.post_header .date').text.to_date
      }
    end

    private

    def agent
      @agent ||= Mechanize.new
    end
  end
end
