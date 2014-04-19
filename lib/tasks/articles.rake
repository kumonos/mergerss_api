namespace :articles do
  desc 'Fetch Articles'

  task fetch: :environment do
    # source 全件更新
    Source.all.each do |source|
      p source.fetch!
    end
  end
end
