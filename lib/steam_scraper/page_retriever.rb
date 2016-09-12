# Retrieves a URL and return the Nokogiri representation of that page
require 'httparty'
require 'nokogiri'

# Class for retrieving a Nokogiri tree from a URL
class PageRetriever
  def retrieve(url)
    page_contents = HTTParty.get(url)
    Nokogiri::HTML(page_contents)
  rescue
    nil
  end
end
