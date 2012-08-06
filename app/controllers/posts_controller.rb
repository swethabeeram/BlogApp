class PostsController < ApplicationController

  before_filter :check_logged_in, :only => [:create, :new, :edit, :update, :destroy]

  before_filter :get_post_object, :only => [:show, :edit, :update, :destroy]

  before_filter :check_owner, :only => [:edit, :update, :destroy]

  private

  def get_post_object
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      flash[:error] = "Sorry, No post was found!"
      redirect_to posts_path
    end    
  end
  
  def check_owner
    if @post.user!=current_user
      flash[:error] = "Sorry, You are not a valid user"
      redirect_to posts_path
    end
  end
  
  public

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "Post has been successfully created"
      NotificationMailer.newpost(@post.user, @post).deliver
      redirect_to posts_path
    else
      render :action => :new
    end
  end

  def show
    @comment = Comment.new
  end


  def edit
  end

  def update
    if @post.update_attributes(params[:post])
      flash[:notice] = "Post has been successfully updated."
      redirect_to post_path(@post)
    else
      render :action => :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post has been deleted."
    redirect_to posts_path
  end
end
