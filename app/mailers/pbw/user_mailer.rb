module Pbw
  class UserMailer < ActionMailer::Base
    default :from => Pbw.email_from_address

    def registration(user_id)
      @user = User.find(user_id)
      mail(:to => @user.email, :subject => I18n.t('pbw.users.registration.subject'))
    end

    def password_reset(user_id, password)
      @user = User.find(user_id)
      @password = password
      mail(:to => @user.email, :subject => I18n.t('pbw.users.password_reset.subject'))
    end 
  end
end
