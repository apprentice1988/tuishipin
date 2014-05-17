class Crawler
  class YoukuCrawler
    require 'open-uri'

    def initialize(youku_url)
      @video = Youku.new(youku_url)
      @page = Nokogiri::HTML(open(youku_url))
    end

    def scrape
      get_basic_info
      get_like_info
    end


    private

    BASEURL = "http://www.youku.com/"
    STARTUP = 'http://v.youku.com/v_show/id_XNzEyMzg2Mzcy_ev_1.html'

    def get_basic_info
      @video.title = @page.xpath("//span[@id='subtitle']").text()
      @video.description = @page.xpath("//div[@id='text_long']").text()
    end

    def get_like_info
      @video.ups = @page.xpath("//span[@id='upVideoTimes']").text().sub(',','').to_i
      @video.downs = @page.xpath("//span[@id='downVideoTimes']").text().sub(',','').to_i
    end

  end
end
