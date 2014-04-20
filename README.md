# Merge RSS JSON REST API Specs

## List Articles API
記事を投稿日の新しい順に返します。

### Request

```
GET /api/1/articles.json
```

Key|Default|Required|Description
---|-------|--------|-----------
since|-|No|指定日時以降に更新された記事を返します（指定時刻は含まない）。数値の場合は Unix 時刻と解釈し、それ以外の場合は Ruby で <code>DateTime.parse</code> を試みます。いずれも失敗した場合、 400 エラーを返します
until|-|No|指定日時以前に更新された記事を返します（指定時刻は含まない）。指定は since 同様です
limit|12|No|上限の件数を指定します
callback|-|No|指定した場合、 JSONP 形式で返すようになります（未実装）

### Response

Status|Description
------|-----------
200 OK|正常終了
400 Bad Request|パラメータが不正
404 Not Found|指定の条件で1件も該当なし
500 Internal Server Error|内部サーバーエラー

Key|Description
---|-----------
status|'OK' / 'NG'
message|エラーの場合、エラー内容が格納されることがあります
articles|記事の配列。中身は下記の例を参照
cursor|続きを読み込みたい場合に指定するパス

下記はレスポンスの例です。

```
{
  "status": "OK",
  "message": null,
  "articles": [
    {
      "title": "4月から社会人5年目になる俺へ",
      "link_url": "http://youcune.com/mono/column/worked_5_years.html",
      "published_at": "2014/04/01 15:00:00",
      "published_at_iso8601": "2014-04-01T15:00:00+09:00",
      "published_at_unix": 1396332000
    },
    {
      "title": "MacBook Proを買ったので運用を考えなおしてみた",
      "link_url": "http://youcune.com/mono/mac/mac_operation.html",
      "published_at": "2014/03/21 15:00:00",
      "published_at_iso8601": "2014-03-21T15:00:00+09:00",
      "published_at_unix": 1395381600
    },
    {
      "title": "雪の降る夜にフラッシュ撮影すると面白い",
      "link_url": "http://youcune.com/mono/photo/snowy_night.html",
      "published_at": "2014/02/07 15:00:00",
      "published_at_iso8601": "2014-02-07T15:00:00+09:00",
      "published_at_unix": 1391752800
    }
  ],
  "cursor": "/api/1/articles.json?until=1391752800\u0026limit=12"
}
```

## Fetch Articles API
指定したブログの記事データを手動で更新する場合に使用します。 Wordpress などで更新通知 Ping の送信先に指定することを想定しています。

※ 現在実装中のためまだ使用できません。作ってプルリクくださいｗ

### Request

```
POST /api/1/fetch/:source_id.json
```
