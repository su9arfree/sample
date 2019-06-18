class PostsController < ApplicationController
	def index
		@posts = Post.paginate(page: params[:page], per_page: 10)
	end

	def show
		@posts = Post.find(params[:id])
	end
	
	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_url
	end
	

end
