require 'rss'

class RSSParser
  def self.parse_since(str, since = nil)
    rss = RSS::Parser.parse(str, true)

    case rss
      when RSS::Atom::Feed
        self.parse_atom(rss, since)
      when RSS::Rss
        self.parse_rss(rss, since)
    end
  end

  private
    def self.parse_atom(rss, since)
      TypeError unless rss.kind_of?(RSS::Atom::Feed)
      articles = []

      rss.entries.each do |entry|
        next if !since.nil? && entry.published.content <= since

        articles << Article.new(
            title: entry.title.content,
            summary: entry.content.content,
            link_url: entry.id.content,
            published_at: entry.published.content.to_datetime
        )
      end

      articles
    end

    def self.parse_rss(rss, since)
      raise TypeError unless rss.kind_of?(RSS::Rss)

      articles = []
      rss.channel.items.each do |item|
        next if !since.nil? && item.pubDate <= since

        articles << Article.new(
            title: item.title,
            summary: item.description,
            link_url: item.link,
            published_at: item.pubDate.to_datetime
        )
      end
      articles
    end
end
