json.status 'OK'
json.message nil
json.articles @articles do |article|
  json.extract! article, :title, :link_url, :published_at_unix, :published_at_iso8601
  json.published_at article.published_at_display
end
json.cursor @cursor
