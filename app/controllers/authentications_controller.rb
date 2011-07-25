class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :create ]
  
  # POST /authentications
  # POST /authentications.json
  def create
    omniauth = request.env['omniauth.auth']
        
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = t('controllers.authentications.signed_in')
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => (omniauth['credentials']['token'] rescue nil))
      flash[:notice] = t('controllers.authentications.authentication_created')
      redirect_to user_url(current_user)
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = t('controllers.authentications.signed_in')
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  # DELETE /authentications/1
  # DELETE /authentications/1.json
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :ok }
    end
  end
end
