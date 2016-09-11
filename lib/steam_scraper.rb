require 'steam_scraper/version'
require 'steam_scraper/game_list_scraper'
require 'steam_scraper/game_page_scraper'

# Module that provides all SteamScraper functionality
module SteamScraper
  # Class actually scrapes the Steam Store
  class SteamScraper
    def initialize(*_args)
      @game_list_scraper = GameListScraper.new
      @game_page_scraper = GamePageScraper.new
    end

    def scrape(first_page = 1, last_page = nil)
      scraped_game_list = @game_list_scraper.scrape(first_page, last_page)
      final_game_list = @game_page_scraper.scrape(scraped_game_list)

      final_game_list
    end
  end
end
