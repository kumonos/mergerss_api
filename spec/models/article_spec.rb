require 'spec_helper'

describe Article do
  before do
    @article = build(:article, published_at: DateTime.new(2014, 4, 20, 17, 20, 25, '+0900'))
  end

  describe '#published_at_unix' do
    it 'UNIX 時刻を返す' do
      expect(@article.published_at_unix).to eq 1397982025
    end
  end

  describe '#published_at_iso8601' do
    it 'ISO8601 形式で返す' do
      expect(@article.published_at_iso8601).to eq '2014-04-20T17:20:25+09:00'
    end
  end

  describe '#published_at_display' do
    it 'yyyy/mm/dd hh:mm:ss 形式で返す' do
      expect(@article.published_at_display).to eq '2014/04/20 17:20:25'
    end
  end
end
