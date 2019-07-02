class MicropostsController < ApplicationController

	def index
		@microposts = Micropost.paginate(page: params[:page], per_page: 20).order(created_at: :desc)
	end

	def create 
		micropost = current_user.microposts.create(content: params[:micropost][:content])
		if micropost.save
			flash[:success] = "post has been created "
		else
			flash[:danger] = "false"
		end
		redirect_to action: :index
	end

	def destroy
		@micropost = Micropost.find(params[:id])
		@micropost.destroy
		flash[:success] = "your post has been deleted"
		redirect_to action: :index		
	end

end
