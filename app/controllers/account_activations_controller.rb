class AccountActivationsController < ApplicationController
	def edit
		user = User.find_by(email: params[:email])
		if user && !user.activated? && user.authenticated?(:activation, params[:id])
			user.activate
			user.categories << user.categories.create(name: 'Everything')
			user.galleries << user.galleries.create(title: 'Everything')
			log_in user
			flash[:success] = 'Account activated!'
			redirect_to user

		else
			flash[:danger] = 'Invalid activation link'
			redirect_to root_url
		end
	end
end

# Add default image for empty Galleries
# how do I add Everything Cataegory and Everything Gallery that can't be deleted
