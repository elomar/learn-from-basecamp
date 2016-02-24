require 'selenium-webdriver'
require 'mechanize'

module Parser
  class Medium
    INDEX = Rails.root.join("db", "seeds", "medium-bootstrap.html")
    SOURCE = "Signal v. Noise"

    def urls
      Nokogiri::HTML(INDEX.read).search('//article[contains(@class, "postArticle--short")]/a/@href').map(&:value)
    end

    def document(url)
      driver.navigate.to(url)
      html = driver.find_element(xpath: '/html').attribute('innerHTML')
      page = Nokogiri::HTML(html)

      title = page.search('h3.graf--h3.graf--first').text

      return { 
        title: title,
        content: page.search('//main[contains(@class, "postArticle-content")]').text.sub(title, ''),
        author: page.search('//meta[@name="author"]/@content').first.value,
        source: SOURCE,
        url: page.search('//meta[@property="og:url"]/@content').first.value,
        published_on: page.search('//meta[@property="article:published_time"]/@content').first.value.to_date
      }
    end

    private

    def driver
      @driver ||= Selenium::WebDriver.for :firefox
    end
  end
end
