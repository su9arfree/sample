class PasswordResetsController < ApplicationController
	before_action :set_user, only: 	 [:edit, :update]


  def new
  end

  def create 
  	@user = User.find_by(email: params[:password_reset][:email].downcase)
  	if  @user
  		@user.create_reset_digest
  		@user.send_password_reset_email
  		flash[:info] = "Check ur email"
  		redirect_to root_url
  	else
  		render 'new', alert: "Wrong Email"
  		#flash.now[:danger] = "Email is invalid"
  	end
  end

  def edit
  	unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
  		redirect_to root_url
  	end
  end

  def update
  	if @user.password_reset_expired?
  		flash[:danger] = "Password resets has expired"
  		redirect_to new_password_reset_url
  	elsif params[:user][:password].empty?
  		@user.errors.add(:password, "can't be empty")
  		render 'edit'
  	elsif @user.update_attributes(user_params)
  		flash[:success] = "password has been reset"
  		redirect_to root_url
  	else
  		render 'edit'
  	
  	end
  end


  private

  def user_params
  	params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user
  	@user = User.find_by email: params[:email]
  end
end
