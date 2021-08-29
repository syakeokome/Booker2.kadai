class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user,   only: [:edit, :update]
  def show
    @user=User.find(params[:id])
    @books=@user.books
    @book = Book.new
  end

  def index
    @users=User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] ="You have updated user successfully"
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = "It's error"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
      user = User.find(params[:id])
      if current_user.id != user.id
        redirect_to user_path(current_user.id)
      end
  end

end
