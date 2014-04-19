require 'json'

class QiitaParser
  def self.parse_since(str, since = nil)
    json = JSON.parse(str)

    articles = []

    json.each do |i|
      next if !since.nil? && DateTime.parse(i['created_at']) <= since

      articles << Article.new(
          title: i['title'],
          summary: i['body'],
          link_url: i['url'],
          published_at: DateTime.parse(i['created_at'])
      )
    end

    articles
  end
end
