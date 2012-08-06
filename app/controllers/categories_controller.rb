class CategoriesController < ApplicationController

  before_filter :get_category, :only =>[:show, :edit, :update, :destroy]

  private
  
  def get_category
    @category = Category.find_by_id(params[:id])
    if @category.nil?
      flash[:error] = "Sorry, Category not found!"
      redirect_to categories_path and return
    end
  end

  public

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "Successfully created new category!"
      redirect_to categories_path
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = "Successfully updated the category!"
      redirect_to categories_path
    else
      render :action => :edit
    end
  end


  def destroy
    if @category == Category.default
      flash[:error] = "Sorry, You cannot delete the default category!"
      redirect_to categories_path and return
    end
    @category.destroy
    flash[:notice] = "Successfully deleted the category!"
    redirect_to categories_path
  end
end
