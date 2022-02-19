# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'pm-lille@naritaya.org'

  def message_notification
    @user = params[:user]
    @message = params[:message]

    mail(to: @user.email, subject: 'PMLille - Nouveau message')
  end
end
