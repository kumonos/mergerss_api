class ArticlesController < ApplicationController
  # GET /api/1/articles.json
  def index
    @articles = Article.all

    # parse parameters
    since_datetime = parse_datetime(params[:since])
    until_datetime = parse_datetime(params[:until])
    limit = (params[:until].presence || 12).to_i

    # search
    @articles = @articles.where('published_at > ?', since_datetime) if since_datetime.present?
    @articles = @articles.where('published_at < ?', until_datetime) if until_datetime.present?
    @articles = @articles.limit(limit) if limit.present?
    @articles = @articles.order(published_at: :desc)

    # render
    render formats: :json
  end

  private
    # 日時の指定を解釈する
    # @param [String] str 日時を表す文字列
    # @return [DateTime] 解釈できなかった場合 nil
    def parse_datetime(str)
      if str =~ /\A\d+\z/
        # 全部数値なら Unix 時刻とみなす
        Time.at(str.to_i).to_datetime
      elsif str.present?
        # 上記以外なら Parse を試みる
        DateTime.parse(str) rescue nil
      else
        nil
      end
    end
end
