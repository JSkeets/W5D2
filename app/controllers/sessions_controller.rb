class SessionsController < ApplicationController
  def new
  end

  def edit
  end

  def update
  end

  def create
    @user = User.find_by_credentials(params[:user][:username],params[:user][:password])
    if @user
      login(@user)
      redirect_to subs_url
    else
      flash[:errors] = ["Invalid Login"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to subs_url
  end

  def show
  end

  def index
  end
end
