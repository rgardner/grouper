class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    print(user_params)
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Thanks for signing in #{@user.name}!"
      redirect_to groups_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :school, known_skills: [],
                                                         wanted_skills: [])
  end
end
