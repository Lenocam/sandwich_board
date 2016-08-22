class AccountActivationsController < ApplicationController
	def edit
		user = User.find_by(email: params[:email])
		if user && !user.activated? && user.authenticated?(:activation, params[:id])
			user.activate
			user.categories << user.categories.create(name: 'Everything')
			log_in user
			flash[:success] = 'Account activated!'
			redirect_to user

		else
			flash[:danger] = 'Invalid activation link'
			redirect_to root_url
		end
	end
end

# can I add a redirect to a one time use only page here after inital activation.
# how do I add Everything Cataegory and Everything Gallery that can't be deleted
