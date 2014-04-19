json.articles @articles do |article|
  json.extract! article, :title, :link_url, :published_at
end
json.next_path @next_path
