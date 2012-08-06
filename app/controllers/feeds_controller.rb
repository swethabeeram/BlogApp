class FeedsController < ApplicationController

  def posts
    @posts = Post.all
  end

  def comments
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      flash[:error] = "Sorry, Post not found"
      redirect_to root_url and return
    end
    @comments = @post.comments
  end
end
