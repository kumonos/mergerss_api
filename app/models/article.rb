class Article < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Relations
  # ------------------------------------------------------------------
  belongs_to :source

  # ------------------------------------------------------------------
  # Public Instance Methods
  # ------------------------------------------------------------------
  # 投稿日時を UNIX 時刻で返す
  # @return [Integer] 投稿日の UNIX 時刻
  def published_at_unix
    self.published_at.to_time.to_i
  end

  # 投稿日時を ISO8601 形式で返す
  # @return [String] ISO 8601 形式の投稿日時
  def published_at_iso8601
    self.published_at.iso8601
  end

  # 投稿日時を表示用の文字列で返す
  # @return [String] 表示用の投稿日時
  def published_at_display
    self.published_at.strftime('%Y/%m/%d %H:%M:%S')
  end
end
