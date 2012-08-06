class NotificationMailer < ActionMailer::Base
  default from: "info@blogapp.com"


  def welcome(user)
    @user = user
    mail(:to=>user.email,:subject=>"Welcome to the Blog app!")
  end

  def newpost(user,post)
    @user = user
    @post = post
    mail(:to=>user.email, :subject=>"New Post Created")
  end

  def mailauthorcomment(user,post,comment)
    @user = user
    @post = post
    @comment = comment
    mail(:to => user.email, :subject=>"New Comment Created")
  end

  def mailownerpost(user,post,comment)
    @user = user
    @post = post
    @comment = comment
    mail(:to => user.email, :subject=>"New Comment Created")
  end

  def mailphotouser(user,photo)
    @user = user
    @photo = photo
    mail(:to => user.email, :subject=>"New Photo Uploaded")
  end

end

