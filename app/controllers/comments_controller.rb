class CommentsController < ApplicationController

  before_filter :check_logged_in, :only => [:create, :new, :edit, :update, :destroy]


  before_filter :get_post

  private

  def get_post
    @post = Post.find_by_id(params[:post_id])
    if @post.nil?
      flash[:notice] = "Sorry, no post was found!"
      redirect_to posts_path
    end
  end

  public

  def create
    @comment = @post.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Comment Successfully Saved!"
      NotificationMailer.mailauthorcomment(@comment.user, @post, @comment).deliver      
      NotificationMailer.mailownerpost(@post.user, @post, @comment).deliver      
      redirect_to post_path(@post)
    else
      flash[:error] = "Errors in savinf the comment, Please try again"
      redirect_to post_path(@post)
    end
  end

  def destroy
    @comment = @post.comments.find_by_id(params[:id])
    @comment.destroy
    flash[:notice] = "Comment has been successfully deleted"
    redirect_to post_path(@post)
  end

end
