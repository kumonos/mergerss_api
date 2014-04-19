require 'spec_helper'

describe ArticlesController do

  describe 'GET index' do
    before do
      @member = create(:member)
      @source = create(:source, member_id: @member.id)
      @article1 = create(:article, source_id: @source.id, published_at: 7.days.ago)
      @article2 = create(:article, source_id: @source.id, published_at: 5.days.ago)
      @article3 = create(:article, source_id: @source.id, published_at: 3.days.ago)
    end

    context '結果がある場合' do
      it '200 OK を返す' do
        get :index
        expect(response.status).to eq 200
      end

      it 'articles が 3 件含まれる' do
        get :index
        expect(assigns(:articles).count).to eq 3
      end

      it 'since 以降の記事が返る' do
        get :index, since: 6.days.ago
        expect(assigns(:articles).count).to eq 2
        expect(assigns(:articles).pluck(:id)).to match_array [@article2.id, @article3.id]
      end

      it 'until 以前の記事が返る' do
        get :index, until: 4.days.ago
        expect(assigns(:articles).count).to eq 2
        expect(assigns(:articles).pluck(:id)).to match_array [@article1.id, @article2.id]
      end

      it 'limit の件数だけ返る' do
        get :index, limit: 2
        expect(assigns(:articles).count).to eq 2
        expect(assigns(:articles).pluck(:id)).to match_array [@article2.id, @article3.id]
      end
    end

    context '条件に該当する記事がない場合' do
      it '404 Not Found を返す' do
        get :index, since: 2.days.ago.to_s
        expect(response.status).to eq 404
      end
    end

    context '不正なパラメータの場合' do
      it '400 Bad Request を返す' do
        get :index, since: 'invalid date'
        expect(response.status).to eq 400
      end
    end
  end
end
