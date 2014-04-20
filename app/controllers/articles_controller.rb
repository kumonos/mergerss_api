class ArticlesController < ApplicationController
  # GET /api/1/articles.json
  def index
    @articles = Article.all

    begin
      # parse parameters
      since_datetime = parse_datetime(params[:since])
      until_datetime = parse_datetime(params[:until])
      limit = (params[:limit].presence || 12).to_i

      # search
      @articles = @articles.where('published_at > ?', since_datetime) if since_datetime.present?
      @articles = @articles.where('published_at < ?', until_datetime) if until_datetime.present?
      @articles = @articles.limit(limit) if limit.present?
      @articles = @articles.order(published_at: :desc)

      # set cursor
      @cursor = "/api/1/articles.json?until=#{@articles.last.published_at_unix}&limit=#{limit}" if @articles.any?

      # render
      render formats: :json, status: @articles.count.zero? ? :not_found : :ok
    rescue DateTimeParseError => e
      # 日付の解釈失敗
      render json: { status: 'NG', message: e.message }, status: :bad_request
    rescue => e
      Rails.logger.fatal e
      render json: { status: 'NG', message: 'Internal Server Error' }, status: :internal_server_error
    end
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
        DateTime.parse(str) rescue raise DateTimeParseError, "invalid format: #{str}"
      else
        nil
      end
    end
end

class DateTimeParseError < StandardError; end
