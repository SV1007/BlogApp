class SessionsController < ApplicationController
  def new
    if logged_in?
        flash[:danger] = "Please log out first!"
        redirect_to '/index'
    end
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		log_in(user)
  		redirect_to '/index'
  	else
  		flash[:danger] = "Email/password combination incorrect!"
  		redirect_to '/login'
  	end
  end

  def destroy 
  	log_out
  	redirect_to '/login'
  end

end
