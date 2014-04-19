# Merge RSS JSON REST API Specs

## List Articles API
記事を投稿日の新しい順に返します。

### Request

```
GET /api/1/articles.json
```

Key|Default|Description
---|-------|-----------
since|なし|指定日時以降に更新された記事を返します（指定時刻は含まない）。数値の場合は Unix 時刻と解釈し、それ以外の場合は Ruby で <code>DateTime.parse</code> を試みます。いずれも失敗した場合、 400 エラーを返します
until|なし|指定日時以前に更新された記事を返します（指定時刻は含まない）。指定は since 同様です
limit|12|上限の件数を指定します
callback|なし|指定した場合、 JSONP 形式で返すようになります（未実装）

### Response

Status|Description
------|-----------
200 OK|正常終了
400 Bad Request|パラメータが不正
404 Not Found|指定の条件で1件も該当なし
500 Internal Server Error|内部サーバーエラー

## Fetch Articles API
指定したブログの記事データを手動で更新する場合に使用します。 Wordpress などで更新通知 Ping の送信先に指定することを想定しています。

※ 現在実装中のためまだ使用できません。作ってプルリクくださいｗ

### Request

```
POST /api/1/fetch/(source_id).json
```
