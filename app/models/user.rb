require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessible :email, :hashed_password, :name, :password, :password_confirmation
  
  attr_accessor :password, :password_confirmation

  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_many :attachments, :dependent => :destroy
  
  validates :name, :presence => true
  validates :email, :uniqueness => true, :presence => true, :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i


  validates :password, :presence => true, :confirmation => true
  validates :password_confirmation, :presence => true


  def self.authenticate(email, password)
    user = find_by_email(email)
    if user
      if Digest::SHA1.hexdigest(password) == user.hashed_password #Password provided matches our record
        return user
      else #i.e password provided is in correct
        return false
      end
    else #user was not found with the provided email, hence we will return false
      return false
    end  
  end

  before_save do
    unless password.blank?
      set_hashed_password
    end
  end

  after_create do
    NotificationMailer.welcome(self).deliver
  end

  private

  def set_hashed_password
      self.hashed_password = Digest::SHA1.hexdigest(password)
  end

end
