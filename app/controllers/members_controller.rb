class MembersController < ApplicationController
  def show
    begin
      @member = Member.find(params[:id])
      render formats: :json
    rescue ActiveRecord::RecordNotFound
      render json: { status: 'NG', message: 'Member not found' }, status: :not_found
    rescue => e
      Rails.logger.fatal e
      render json: { status: 'NG', message: 'Internal Server Error' }, status: :internal_server_error
    end
  end
end
