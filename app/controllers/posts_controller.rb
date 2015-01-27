class PostsController < ApplicationController
	before_action :logged_in_user 

	def index
		@posts = Post.all
	end

	def show
		@post = Post.find_by(id: params[:id])
		@comments = @post.comments
	end

	def new
		@post = @current_user.posts.new
	end

	def create
		@post = @current_user.posts.new(post_params)
		if @post.save
			redirect_to '/index'
		end
	end

	def destroy
		@post = Post.find_by(id: params[:id])
		@post.comments.delete
		@post.delete
		redirect_to '/index'
	end


	private

		def post_params
			params.require(:post).permit(:title, :body)
		end

		def logged_in_user
			unless logged_in?
				flash[:danger] = "Please log in!"
				redirect_to '/login'
			end
		end
end
