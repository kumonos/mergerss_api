require 'spec_helper'

describe RSSParser do
  context 'Qiita API' do
    before do
      @json = <<-'__END_OF_DOCUMENT__'
[{"id":58473,"uuid":"6c3463e87f21b158ac61","user":{"id":19478,"url_name":"youcune","profile_image_url":"https://secure.gravatar.com/avatar/bda36e025600f9e5a400dea0a1f08db1"},"title":"Rails (ActiveRecord) で scope と joins する方法","created_at":"2014-04-10 12:17:42 +0900","updated_at":"2014-04-10 12:21:19 +0900","created_at_in_words":"9日","updated_at_in_words":"9日","tags":[{"name":"Rails","url_name":"rails","icon_url":"https://s3-ap-northeast-1.amazonaws.com/qiita-tag-image/5310a6d3a8555d87a7060deec2c9e128bf3b3372/medium.jpg?1364838150","versions":["4.0.3"]},{"name":"ActiveRecord","url_name":"activerecord","icon_url":"/icons/medium/missing.png","versions":["4.0.3"]}],"stock_count":3,"comment_count":0,"url":"http://qiita.com/youcune/items/6c3463e87f21b158ac61","created_at_as_seconds":1397099862,"tweet":true,"gist_url":null,"private":false,"raw_body":"## 答え\n\n[ActiveRecord::SpawnMethods#merge](http://api.rubyonrails.org/classes/ActiveRecord/SpawnMethods.html#method-i-merge) を使うらしい。","body":"\u003Ch2\u003E\n        \u003Cspan id=\"2-1\" class=\"fragment\"\u003E\u003C/span\u003E\n        \u003Ca href=\"#2-1\"\u003E\u003Ci class=\"fa fa-link\"\u003E\u003C/i\u003E\u003C/a\u003E答え\n      \u003C/h2\u003E\u003Cp\u003E\u003Ca href=\"http://api.rubyonrails.org/classes/ActiveRecord/SpawnMethods.html#method-i-merge\" title=\"\" target=\"_blank\"\u003EActiveRecord::SpawnMethods#merge\u003C/a\u003E を使うらしい。\u003C/p\u003E","stock_users":["hnakamur","kasumani","Reds"]},{"id":53427,"uuid":"f5371d449d2486c67357","user":{"id":19478,"url_name":"youcune","profile_image_url":"https://secure.gravatar.com/avatar/bda36e025600f9e5a400dea0a1f08db1"},"title":"Rangeの範囲内からランダムに数値を選ぶ","created_at":"2014-03-22 20:26:54 +0900","updated_at":"2014-03-22 20:26:54 +0900","created_at_in_words":"28日","updated_at_in_words":"28日","tags":[{"name":"Ruby","url_name":"ruby","icon_url":"https://s3-ap-northeast-1.amazonaws.com/qiita-tag-image/9de6a11d330f5694820082438f88ccf4a1b289b2/medium.jpg?1364837630","versions":["2.1.1"]}],"stock_count":8,"comment_count":0,"url":"http://qiita.com/youcune/items/f5371d449d2486c67357","created_at_as_seconds":1395487614,"tweet":true,"gist_url":null,"private":false,"raw_body":"## 誤りの例\n\n以下で一見良さそうなんですが、そもそもやりたいことができません。Rangeオブジェクトいっこの配列ができるので、この返り値はRangeになります。\n\n```rb\n[1 .. 10000].sample\n```","body":"\u003Ch2\u003E\n        \u003Cspan id=\"2-1\" class=\"fragment\"\u003E\u003C/span\u003E\n        \u003Ca href=\"#2-1\"\u003E\u003Ci class=\"fa fa-link\"\u003E\u003C/i\u003E\u003C/a\u003E誤りの例\n      \u003C/h2\u003E\u003Cp\u003E以下で一見良さそうなんですが、そもそもやりたいことができません。Rangeオブジェクトいっこの配列ができるので、この返り値はRangeになります。\u003C/p\u003E\n\u003Cdiv class=\"code-frame\" data-lang=\"rb\"\u003E\u003Cdiv class=\"highlight\"\u003E\u003Cpre\u003E\u003Cspan class=\"o\"\u003E[\u003C/span\u003E\u003Cspan class=\"mi\"\u003E1\u003C/span\u003E \u003Cspan class=\"o\"\u003E.\u003C/span\u003E\u003Cspan class=\"n\"\u003E.\u003C/span\u003E \u003Cspan class=\"mi\"\u003E10000\u003C/span\u003E\u003Cspan class=\"o\"\u003E].\u003C/span\u003E\u003Cspan class=\"n\"\u003Esample\u003C/span\u003E\n\u003C/pre\u003E\u003C/div\u003E\u003C/div\u003E\u003Ch2\u003E\n","stock_users":["YoshitsuguFujii@github","rentalname@github","naotor@github","quanon86","tuki0918","melodydance_pr","kasumani","Reds"]}]
      __END_OF_DOCUMENT__

      @articles = QiitaParser.parse_since(@json)
    end

    it '件数が一致する' do
      expect(@articles.count).to eq 2
    end

    it '記事の各項目が格納される' do
      first = @articles.first
      expect(first.title).to eq 'Rails (ActiveRecord) で scope と joins する方法'
      expect(first.summary).to include 'ActiveRecord::SpawnMethods#merge'
      expect(first.link_url).to eq 'http://qiita.com/youcune/items/6c3463e87f21b158ac61'
      expect(first.published_at).to eq DateTime.new(2014, 4, 10, 12, 17, 42, '+0900')
    end

    it 'since を渡すと、その日時以降の記事を対象とする' do
      articles_with_since = QiitaParser.parse_since(@json, DateTime.new(2014, 4, 1, 0, 0, 0, '+0900'))
      expect(articles_with_since.count).to eq 1
      expect(articles_with_since.first.title).to eq 'Rails (ActiveRecord) で scope と joins する方法'
    end
  end
end
