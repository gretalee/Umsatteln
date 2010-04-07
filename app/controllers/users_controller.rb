class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :login_required, :only=>[:index]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  
  def index
    @users = User.all
  end

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])

    @user.register! if @user && @user.valid?
    success = @user && @user.valid?

    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = t('registration.message_registration_and_activation_mail')
    else
      flash[:error]  = t('registration.error_registration')
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = t('registration.message_registration_complete')
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = t('registration.error_missing_activation_code')
      redirect_back_or_default('/')
    else 
      flash[:error]  = t('registration.error_no_activation_code')
      redirect_back_or_default('/')
    end
  end
  
  def resend_activation
    user = User.find_by_id(params[:id])
    UserMailer.deliver_signup_notification(user)
    flash[:notice] = t('registration.message_successfully_recent_activation_mail')
    redirect_back_or_default('/')
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_user
    @user = User.find(params[:id])
  end

end
