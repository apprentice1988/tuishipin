class Crawler
  module YoukuCrawler
    extend ActiveSupport::Concern
    require 'open-uri'


    module ClassMethods
      def scrape_youku
        get_basic_info
        get_like_info
      end

      def test_scrape_info(youku_url)
        initialize_video(youku_url)
        get_basic_info
        get_like_info
        @video.save
      end

      private

      BASEURL = "http://www.youku.com/"
      STARTUP = 'http://v.youku.com/v_show/id_XNzEyMzg2Mzcy_ev_1.html'

      def initialize_video(youku_url)
        @video = Youku.new(youku_url)
        @page = Nokogiri::HTML(open(youku_url))
      end

      def get_basic_info
        @video.title = @page.xpath("//span[@id='subtitle']").text()
        @video.description = @page.xpath("//div[@id='text_long']").text()
        @video.tags = @page.xpath('//head/script[5]').text().match(/tags=\"(%|\d|\w|\|)+/).
                      to_s.remove(/tags=\"/).split('|').map {|x| URI.unescape(x) }
        @video.last_seconds = @page.xpath('//head/script[5]').text().
                              match(/Math.round\(\d+/).to_s.match(/\d+/).to_s.to_i
      end

      def get_like_info
        @video.ups = @page.xpath("//span[@id='upVideoTimes']").text().sub(',','').to_i
        @video.downs = @page.xpath("//span[@id='downVideoTimes']").text().sub(',','').to_i
      end
    end
  end
end
