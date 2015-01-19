class CommentsController < ApplicationController
	before_action :logged_in_user
	
	def new
		@post = Post.find_by(id: params[:id])
		@comment = @current_user.comments.new
	end

	def create
		@post = Post.find_by(id: params[:id])
		@comment = @current_user.comments.create(comment_params)
		@comment.post_id = @post.id
		@comment.save
		redirect_to controller: "posts", action: "show", id: @post.id
	end

	def delete
		@comment = Comment.find_by(id: params[:id])
		if @comment.present?
			@id = @comment.post_id
			@comment.delete
		end
		redirect_to controller: "posts", action: "show", id: @id
	end

	private

		def comment_params
			params.require(:comment).permit(:body)
		end

		def logged_in_user
			unless logged_in?
				flash[:danger] = "Please log in!"
				redirect_to '/login'
			end
		end
end
