require_relative './page_retriever.rb'

# Core scraping class
class GameListScraper
  def initialize(*_args)
    @game_list = []
    @page_retriever = PageRetriever.new
    current_page_contents = get_page_contents(site + 1.to_s)
    pagination_contents = current_page_contents.xpath("//div[contains(@class, 'search_pagination_right')]") .text
    last_page_number = pagination_contents.scan(/(\d+)/i) .flatten.last
    @last_page_num = last_page_number.to_i
  end

  def site
    'http://store.steampowered.com/search?page='
  end

  def get_page_contents(url)
    @page_retriever.retrieve(url)
  end

  def search_results(page_number)
    current_page_contents = get_page_contents(site + page_number.to_s)
    current_page_contents.xpath("//div[@id='search_result_container']/div/a")
  end

  def scrape(first_page = 1, last_page = nil)
    last_page ||= @last_page_num
    # scrape each search page
    puts 'Scraping Steam Store pages ' + [first_page..last_page].join(' to ')
    (first_page..last_page).each do |page|
      puts 'Scraping Page ' + page.to_s
      items_on_page = search_results(page)
      scrape_page(items_on_page)
      puts 'Page Complete'
    end
    puts 'Scraping Complete'
    @game_list
  end

  def scrape_page(current_page)
    current_page.each do |entry|
      scrape_entry(entry)
    end
  end

  def scrape_url(entry)
    entry.attribute('href').value
  end

  def scrape_name(entry)
    entry.xpath(".//span[@class='title']").text
  end

  def scrape_price(entry)
    entry.xpath(".//div[contains(@class, 'search_price')
                and not(contains(@class, 'search_price_discount_combined'))]")
         .text
         .strip
         .split('$')
         .last
  end

  def scrape_release_date(entry)
    Date.parse(entry.xpath(".//div[contains(@class, 'search_released')]").text)
  end

  def scrape_platforms(entry)
    platforms = []
    platforms.push('Windows') unless entry.xpath(".//span[contains(@class, 'win')]").empty?
    platforms.push('macOS') unless entry.xpath(".//span[contains(@class, 'mac')]").empty?
    platforms.push('Linux') unless entry.xpath(".//span[contains(@class, 'linux')]").empty?
    platforms.push('Steamplay') unless entry.xpath(".//span[contains(@class, 'steamplay')]").empty?

    platforms
  end

  def scrape_icon_url(entry)
    entry.xpath(".//div[contains(@class, 'search_capsule')]/img").attribute('src').value
  end

  def get_review_contents(entry)
    node = entry.xpath(".//span[contains(@class, 'search_review_summary')]")
    result = nil
    result = node.attribute('data-store-tooltip').value unless node.nil?

    result
  end

  def scrape_review_score(entry)
    review_string = get_review_contents(entry)
    matches = /.*(\d\d)[%]/i.match(review_string)
    review_percentage = matches[1] unless matches.nil?

    review_percentage
  end

  def scrape_number_of_reviews(entry)
    review_string = get_review_contents(entry)
    matches = /.*\d\d[%] of the ([0-9,]*) user/i.match(review_string)
    num_reviews = matches[1] unless matches.nil?

    num_reviews
  end

  def scrape_entry(entry)
    new_game = {}
    new_game[:url] = scrape_url(entry)
    new_game[:name] = scrape_name(entry)
    new_game[:price] = scrape_price(entry)
    new_game[:release_date] = scrape_release_date(entry)
    new_game[:platforms] = scrape_platforms(entry)
    new_game[:icon_url] = scrape_icon_url(entry)
    new_game[:review_score] = scrape_review_score(entry)
    new_game[:number_of_reviews] = scrape_number_of_reviews(entry)
    @game_list.push new_game
  end
end
