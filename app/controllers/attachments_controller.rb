class AttachmentsController < ApplicationController

  before_filter :check_logged_in
  before_filter :get_file, :only => [:download, :destroy]
  before_filter :check_owner, :only => [:destroy, :download]

  private

  def get_file
    @attachment = Attachment.find_by_id(params[:id])
    unless @attachment
      flash[:error] = "Sorry, We couldn't find the requested attachment"
      redirect_to attachments_path
    end    
  end

  def check_owner
    if @attachment.user!=current_user
      flash[:error] = "Sorry, You are not a valid user"
      redirect_to attachments_path
    end
  end
  
  public

  def index
    @attachments = Attachment.where(:user_id => current_user.id)
  end

  def download
    send_file(@attachment.file.path, :filename => @attachment.file_file_name, :disposition => "attachment")
  end

  def new
    @attachment = Attachment.new
  end  

  def create1
    @attachment = Attachment.new(params[:attachment])
    @attachment.user_id = current_user.id
    if @attachment.save
      flash[:notice] = "Attachment has been saved successfully!"
      redirect_to attachments_path
    else
      render :action => :new
    end  
  end


  def create
    @attachment = Attachment.new(params[:attachment])
    @attachment.user_id = current_user.id
    if @attachment.save
      redirect_to attachment_path(@attachment)
    else
      render :action => :new
    end  
  end

  def destroy
    @attachment.destroy
    flash[:notice] = "Attachment has been removed successfully"
    redirect_to attachments_path
  end

end
