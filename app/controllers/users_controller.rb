class UsersController < ApplicationController
	before_action :not_logged_in_user

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			UserMailer.welcome_email(@user).deliver_now
			log_in @user
			flash[:danger] = "Welcome " + @user.email
			redirect_to '/index'
		else
			flash[:danger] = "Signup failed! Make sure data is correctly entered!"
			redirect_to '/signup'
		end
	end

	private

		def not_logged_in_user
			if logged_in?
				flash[:danger] = "Please log out first!"
				redirect_to '/index'
			end
		end

		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end
end
