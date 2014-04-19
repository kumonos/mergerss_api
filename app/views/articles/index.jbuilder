json.status 'OK'
json.message nil
json.articles @articles do |article|
  json.extract! article, :title, :link_url, :published_at
end
json.cursor @next_path
