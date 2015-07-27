class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new    
    @user=User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:userid]=@user.id
     redirect_to(:controller =>'artist',:action =>'search') 
    else
      redirect_to(:controller =>'access',:action => 'login')
    end
  end

  def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end

  def home
    @user=User.all
  end
end
                                        