require 'spec_helper'

describe MembersController do
  describe 'GET show' do
    before do
      @member = create(:member)
    end

    context '結果がある場合' do
      it '200 OK を返す' do
        get :show, id: @member.id
        expect(response.status).to eq 200
      end

      it '指定した ID の Member が View に渡る' do
        get :show, id: @member.id
        expect(assigns(:member).id).to eq @member.id
      end
    end

    context '結果がない場合' do
      it '404 Not Found を返す' do
        get :show, id: 99999
        expect(response.status).to eq 404
      end
    end
  end
end
