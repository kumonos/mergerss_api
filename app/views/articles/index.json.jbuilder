json.status 'OK'
json.message nil
json.articles @articles do |article|
  json.extract! article, :title, :link_url, :published_at_unix, :published_at_iso8601
  json.published_at article.published_at_display
  json.source_name article.source.name
  json.source_link_url article.source.link_url
  json.member_name article.source.member.name
  json.member_link_url article.source.member.link_url
end
json.cursor @cursor
