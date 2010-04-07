class UserMailer < ActionMailer::Base
  
  def signup_notification(user)
    setup_email(user)
    @subject    += I18n.t('registration.subject_activate')  
    @body[:url]  = "http://#{SITE_URL}/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += I18n.t('registration.subject_activation_complete')
    @body[:url]  = "http://#{SITE_URL}/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "#{SITE_NAME} Support <#{EMAIL_ADMIN}>"
      @subject     = "#{SITE_NAME}: "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
