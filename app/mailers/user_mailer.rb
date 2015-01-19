class UserMailer < ActionMailer::Base
  default from: "shrivantbhartia2016@u.northwestern.edu"

  def welcome_email(user)
  	@user = user
  	mail(to: @user.email, subject: 'Welcome to BlogApp!')  	
  end
  
  
end
