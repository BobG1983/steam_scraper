# Retrieves a URL and return the Nokogiri representation of that page
require 'httparty'
require 'nokogiri'

# Class for retrieving a Nokogiri tree from a URL
class PageRetriever
  def get_age_check_url(url)
    url.sub('/app/', '/agecheck/app/')
  end

  def retrieve(url)
    page_contents = HTTParty.get(url)
    page = Nokogiri::HTML(page_contents)
    if page.xpath('//form[@id="agecheck_form"]')
      url = get_age_check_url(url)
      page_contents = HTTParty.post(url, body: { ageDay: 1, ageMonth: 1, ageYear: 1980 })
      page = Nokogiri::HTML(page_contents)
    end
    page
  rescue
    nil
  end
end
