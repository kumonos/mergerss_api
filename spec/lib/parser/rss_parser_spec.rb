require 'spec_helper'

describe RSSParser do
  context 'RSS 2.0' do
    before do
      @xml = <<-'__END_OF_DOCUMENT__'
        <?xml version="1.0" encoding="UTF-8"?>
        <rss version="2.0"
          xmlns:content="http://purl.org/rss/1.0/modules/content/"
          xmlns:wfw="http://wellformedweb.org/CommentAPI/"
          xmlns:dc="http://purl.org/dc/elements/1.1/"
          xmlns:atom="http://www.w3.org/2005/Atom"
          xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
          xmlns:slash="http://purl.org/rss/1.0/modules/slash/"
        >
          <channel>
            <title>つくログ</title>
            <atom:link href="http://blog.t-tu.com/feed/" rel="self" type="application/rss+xml" />
            <link>http://blog.t-tu.com</link>
            <description>Webサービス・アプリケーションなど、渡邊タツアキのつくったものの記録たち</description>
            <item>
              <title>【報告】Picsy新規登録の出来ないバグ修正と利用状況</title>
              <link>http://blog.t-tu.com/2014/04/08/picsy_bug_fix/</link>
              <pubDate>Mon, 07 Apr 2014 16:07:38 +0000</pubDate>
              <category><![CDATA[ものづくり]]></category>
              <guid isPermaLink="false">http://blog.t-tu.com/?p=429</guid>
              <description><![CDATA[去年の１１月中旬(約半年前)に作ったサービスPicsy InstagramがFacebookに買収された辺りか [&#8230;]]]></description>
              <content:encoded><![CDATA[<p><a href="http://blog.t-tu.com/wp-content/uploads/skitch2.png"><img src="http://blog.t-tu.com/wp-content/uploads/skitch2-300x222.png" alt="skitch" width="300" height="222" class="alignnone size-medium wp-image-431" /></a></p>
          <p>去年の１１月中旬(約半年前)に作ったサービス<a href="http://picsy.t-tu.com">Picsy</a></p>
          <p>InstagramがFacebookに買収された辺りからTwitter上でシェアをしてもinstagramのURLしか表示されなくなってしまっていたので、<br />
          自動でそれを表示される形でつぶやき直すというサービスを作っていました。</p>
          <p>最近になって「登録が出来ません」という報告があり調査していましたら、<br />
          ツイッターを最近始めたユーザーだけ登録できないというバグがありました。</p>
          <p>（報告してくれたのが女の子だったので「<a href="https://twitter.com/Morisuke08">もりすけ</a>界隈か、くそ、かわいい子ばっかあいつめ、、、」と思っていたらどうやら違うようで、instagramとかで検索してくれて使おうとしてくれたのかな？）</p>]]></content:encoded>
            </item>
            <item>
              <title>Pocketを利用した「あとで読む」事による情報収集効率化</title>
              <link>http://blog.t-tu.com/2014/03/30/smart_pocket/</link>
              <comments>http://blog.t-tu.com/2014/03/30/smart_pocket/#comments</comments>
              <pubDate>Sun, 30 Mar 2014 14:25:10 +0000</pubDate>
              <dc:creator><![CDATA[tatsuakiwatanabe]]></dc:creator>
              <category><![CDATA[Webサービス]]></category>
              <guid isPermaLink="false">http://blog.t-tu.com/?p=418</guid>
              <description><![CDATA[あのPocketが今まで日本語対応してなかったのが3月19日についに対応になりました〜パチパチ という事で久し [&#8230;]]]></description>
              <content:encoded><![CDATA[<p>あのPocketが今まで日本語対応してなかったのが3月19日についに対応になりました〜パチパチ<br />
          という事で久しぶりに使い直してみたらめっちゃ便利になってる！</p>
                <p>って事で「後で読むツール」として使わせていただいております。<br />
          そこでこの便利ツールとおすすめな使い方をご紹介！</p>]]></content:encoded>
            </item>
          </channel>
        </rss>
      __END_OF_DOCUMENT__

      @articles = RSSParser.parse_since(@xml)
    end

    it '件数が一致する' do
      expect(@articles.count).to eq 2
    end

    it '記事の各項目が格納される' do
      first = @articles.first
      expect(first.title).to eq '【報告】Picsy新規登録の出来ないバグ修正と利用状況'
      expect(first.summary).to eq '去年の１１月中旬(約半年前)に作ったサービスPicsy InstagramがFacebookに買収された辺りか [&#8230;]'
      expect(first.link_url).to eq 'http://blog.t-tu.com/2014/04/08/picsy_bug_fix/'
      expect(first.published_at).to eq DateTime.new(2014, 4, 8, 1, 07, 38, '+0900')
    end

    it 'since を渡すと、その日時以降の記事を対象とする' do
      articles_with_since = RSSParser.parse_since(@xml, DateTime.new(2014, 4, 1, 0, 0, 0, '+0900'))
      expect(articles_with_since.count).to eq 1
      expect(articles_with_since.first.title).to eq '【報告】Picsy新規登録の出来ないバグ修正と利用状況'
    end
  end

  context 'ATOM' do
    before do
      @xml = <<-'__END_OF_DOCUMENT__'
        <?xml version="1.0" encoding="UTF-8"?>
        <feed xmlns="http://www.w3.org/2005/Atom">
          <title>@youcune Monolog</title>
          <id>http://youcune.com/mono</id>
          <link href="http://youcune.com/mono"/>
          <link href="http://youcune.com/mono/feed.xml" rel="self"/>
          <updated>2014-04-01T15:00:00Z</updated>
          <author>
            <name>@youcune</name>
          </author>
          <entry>
            <title>4月から社会人5年目になる俺へ</title>
            <link rel="alternate" href="http://youcune.com/mono/column/worked_5_years.html"/>
            <id>monolog:column/worked_5_years.html</id>
            <published>2014-04-01T15:00:00Z</published>
            <updated>2014-04-01T15:00:00Z</updated>
            <author>
              <name>@youcune</name>
            </author>
            <content type="html">&lt;h3&gt;自分は何年目かわからん&lt;/h3&gt;
              &lt;p&gt;もはや自分が社会人何年目なのか、パッと答えられなくなっていました。同期のtwitterで5年目と知りました。今後悩むのも癪なので公式を考えました。この公式を使えば、いつでも自分が何年目かがわかります。&lt;/p&gt;
            </content>
          </entry>
          <entry>
            <title>MacBook Proを買ったので運用を考えなおしてみた</title>
            <link rel="alternate" href="http://youcune.com/mono/mac/mac_operation.html"/>
            <id>monolog:mac/mac_operation.html</id>
            <published>2014-03-21T15:00:00Z</published>
            <updated>2014-03-21T15:00:00Z</updated>
            <author>
              <name>@youcune</name>
            </author>
            <content type="html">&lt;p&gt;先日、このタイミングで&lt;a href="http://www.amazon.co.jp/gp/product/B00G55EJYW/ref=as_li_tf_tl?ie=UTF8&amp;camp=247&amp;creative=1211&amp;creativeASIN=B00G55EJYW&amp;linkCode=as2&amp;tag=youcune-22"&gt;MacBook Pro 13インチ Retinaディスプレイモデル&lt;/a&gt;&lt;img src="http://ir-jp.amazon-adsystem.com/e/ir?t=youcune-22&amp;l=as2&amp;o=9&amp;a=B00G55EJYW" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" /&gt;を購入しました。今までiMac Mid 2011とMacBook Air Late 2010を使っていたんですが、&lt;/p&gt;
            </content>
          </entry>
        </feed>
      __END_OF_DOCUMENT__

      @articles = RSSParser.parse_since(@xml)
    end

    it '件数が一致する' do
      expect(@articles.count).to eq 2
    end

    it '記事の各項目が格納される' do
      first = @articles.first
      expect(first.title).to eq '4月から社会人5年目になる俺へ'
      expect(first.summary).to include '自分は何年目かわからん'
      expect(first.link_url).to eq 'http://youcune.com/mono/column/worked_5_years.html'
      expect(first.published_at).to eq DateTime.new(2014, 4, 2, 0, 0, 0, '+0900')
    end

    it 'since を渡すと、その日時以降の記事を対象とする' do
      articles_with_since = RSSParser.parse_since(@xml, DateTime.new(2014, 4, 1, 0, 0, 0, '+0900'))
      expect(articles_with_since.count).to eq 1
      expect(articles_with_since.first.title).to eq '4月から社会人5年目になる俺へ'
    end
  end
end
