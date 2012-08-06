class Photo < ActiveRecord::Base
  attr_accessible :user_id, :photo

  belongs_to :user

  has_attached_file :photo, :styles =>{:thumb => "50x50>", :medium => "100x100"}, 
:path => ":rails_root/public/system/:attachment/:id/:style/:filename", 
:url => "/system/:attachment/:id/:style/:filename"

end
