class Source < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Relations
  # ------------------------------------------------------------------
  belongs_to :member
  has_many :articles

  # ------------------------------------------------------------------
  # Public Instance Methods
  # ------------------------------------------------------------------
  def fetch!
    begin
      body = get_body(self.source_url)

      # parser_class に処理を委譲
      fetched = Object.const_get(self.parser_class).parse_since(body, self.last_published_at)
      self.articles << fetched
      self.last_published_at = self.articles.map{ |a| a.published_at }.max
      self.save!
      fetched
    rescue => e
      Rails.logger.warn "Failed: #{e.class} #{e.message}"
    end
  end

  private
    def get_body(url)
      Net::HTTP.get_response(URI.parse(url)).body
    end
end
