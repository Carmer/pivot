class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "User has been successfully created!"
      redirect_to user_path(@user)
    else
      flash[:errors] = @user.errors.full_messages(", ").join
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user 
    else
      render :edit
    end
  end
  private

  def user_params
    params.require(:user).permit(
                                  :name,
                                  :username,
                                  :email,
                                  :password,
                                  :password_confirmation
                                  )
  end
end
