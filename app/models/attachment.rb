class Attachment < ActiveRecord::Base
  attr_accessible :user_id, :file

  belongs_to :user

  has_attached_file :file, 
:path => ":rails_root/private/user_data/:attachments/:id/:filename"

end
