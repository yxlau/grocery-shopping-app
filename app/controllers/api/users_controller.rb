class Api::UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]

  def create
    @user = User.new(whitelisted_params)
    if @user.save
      @token = Knock::AuthToken.new(payload: { sub: @user.id}).token
      render :show, status: :created
    else
      render json: {error: @user.errors.full_messages, status: 422}, status: :unprocessable_entity
    end
  end

  def show
    render json: {id: current_user.id, username: current_user.username}
  end

  private

  def whitelisted_params

    params.require(:user).permit(:email, :password, :password_confirmation, :username) if params[:user]

  end
end
