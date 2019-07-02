class RelationshipsController < ApplicationController
  def create
  	@user = User.find params[:followed_id]
  	current_user.active_relationships.create! followed_id: @user.id
  	respond_to do |format|
  		format.html{redirect_to @user}
  		format.js
  	end
  end

  def destroy
  	@user = Relationship.find(params[:id]).followed
  	current_user.active_relationships.find_by(followed_id: @user.id).destroy
  	respond_to do |format|
  		format.html{redirect_to @user}
  		format.js
  	end
  end
end
