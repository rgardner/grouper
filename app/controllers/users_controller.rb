class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:sucess] = 'Thanks for signing in.'
      redirect_to 'static_page#index'
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :school, :skills)
  end
end
