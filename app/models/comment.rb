class Comment < ActiveRecord::Base
  attr_accessible :comment, :post_id

  default_scope :order => "created_at DESC"

  belongs_to :post
  belongs_to :user

  validates :comment, :presence => true
  validates :post_id, :presence => true

end
