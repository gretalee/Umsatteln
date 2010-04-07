# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      flash[:notice] = t('login.message_login_successfully')
    else
      user = User.find_by_login( params[:login])
      
      if(user && user.authenticated?(params[:password]) && !user.active?)
        flash[:notice] =  t('login.message_not_activated') 
        flash[:notice] +=  t('login.message_resend_activation', {:user_id => user.id})  
      else
        flash[:notice] = t('login.message_login_failed')
      end
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = t('login.message_logged_out')
    redirect_back_or_default('/')
  end

protected

end
