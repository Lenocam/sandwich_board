class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = 'Account activated!'
      redirect_to user
      # can I add a redirect to a one time use only page here after inital activation.
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end
end
