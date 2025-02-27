class UsersController < ApplicationController
  def new

  end

  def show
    if current_user
      @user = User.find(params[:id])
    else
      flash[:error] = "You must be logged in or registered to visit the dashboard."
      redirect_to '/'
    end
    # @hosting = @user.hosted_parties(params[:id])
    # @invited = @user.invited_parties
  end

  def create
    @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "User was successfully created"
        redirect_to user_path(@user)
      else
        flash[:error] = "Info is not valid"
        render :new
      end
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.email}!"
      redirect_to user_path(user)
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/'
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end