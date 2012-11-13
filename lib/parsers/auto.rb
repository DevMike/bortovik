require 'mechanize'

class AutoParser
  RESULT_FILENAME = 'db/seed/cars.yml'
  BASE_URL = 'http://catalog.auto.ru'
  START_PAGE = '/catalog/cars/'
  LINKS_HOLDERS = [
    '.content.auto a',
    '.block.content div:first-child table.list a',
    '.block.content tr.newssubtitle a'
  ]
  AUTO_TABLE_SELECTOR = '[bgcolor="#006C8A"]'

  def initialize
    @agent = Mechanize.new
    @agent.user_agent_alias = 'Mac Safari'
    @result = {}
  end

  def execute
    @result = {}
    go_tree START_PAGE, @result
    save
  end

  def go_tree link, category, nesting = 0
    page = @agent.get(BASE_URL + link)
    if nesting < LINKS_HOLDERS.length
      page.search(LINKS_HOLDERS[nesting]).each do |sublink|
        title = sublink.text
        category[title] ||= {'children' => {}}
        go_tree sublink['href'], category[title]['children'], nesting + 1
      end
    else
      parse_car page, category
    end
  rescue Exception => e
    log e, link
  end

  def parse_car page, auto
    table = page.at(AUTO_TABLE_SELECTOR)
    part = {}
    table.search('tr').each do |tr|
      cells = tr.search('td').map(&:text)
      feature_name = cells.first
      if cells.count == 1
        feature_category = cells.first
        auto[feature_category] ||= {}
        part = auto[feature_category]
      else
        feature_name = cells.first
        feature_value = cells[1]
        part[feature_name] = feature_value
      end
    end
  end

  def save
    File.open(RESULT_FILENAME, "w") do |f|
      f.write(@result.to_yaml)
    end
  end

  def log error, page
    Rails.logger.error "Unable to parse #{page} page. Error: #{error}"
  end
end
