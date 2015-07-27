class AccessController < ApplicationController

  before_action :confirm_logged_in, :except => [:login,:attempt_login,:logout]

  def index

  end

  def login
    
  end

  def attempt_login
    if params[:email].present? && params[:password].present?
      found_user=User.where(:email => params[:email]).first
      if found_user
        authorised_user=found_user.authenticate(params[:password])
      end
    end
    if authorised_user
      session[:userid] = authorised_user.id
      flash[:notice] ="logged in"
      redirect_to(:controller =>'artist', :action =>'search')
    else
      flash[:notice] ="invalid user"
      redirect_to(:action =>'login')
    end

  end


  def logout
    session[:userid] = nil
    redirect_to(:action =>"login")
  end
  

end
