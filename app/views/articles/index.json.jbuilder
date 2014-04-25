json.status 'OK'
json.message nil
json.articles @articles do |article|
  json.extract! article, :title, :link_url, :published_at_unix, :published_at_iso8601
  json.published_at article.published_at_display
  json.source_id article.source.id
  json.source_name article.source.name
  json.source_link_url article.source.link_url
  json.member_id article.source.member.id
  json.member_name article.source.member.name
end
json.cursor @cursor
