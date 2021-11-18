class AgentMailer < ApplicationMailer
  default from: "pm-lille@naritaya.org"

  def message_notification
    @agent = params[:agent]
    @message = params[:message]

    mail(to: @agent.email, subject: "PMLille - Nouveau message")
  end
end
