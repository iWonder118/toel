class ContentsController < ApplicationController
  def index
    @contents = Content.includes(:user).page(params[:page]).per(10).order("created_at DESC")
  end

  def new
  end

  def create
    Content.create(text: content_params[:text],favcount: 0 ,user_id: current_user.id)
    redirect_to action: :index 
  end

  def destroy
    content = Content.find(params[:id])
    content.destroy if content.user_id == current_user.id
    redirect_to action: :index 
  end

  def edit
    @content = Content.find(params[:id])
  end

  def update
    content = Content.find(params[:id])
    content.update(content_params) if content.user_id == current_user.id
    redirect_to action: :index 
  end
  
  private
  def content_params
    params.permit(:text)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
