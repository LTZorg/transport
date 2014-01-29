class UsersController < ApplicationController
	before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user,     only: :destroy

	def index
		@users = User.paginate(page: params[:page], :per_page => 5)
	end

	def show
		@user = User.find(params[:id])
	end

	def new
	end

	def destroy
		@user = User.find(params[:id])
		if current_user?(@user)
		redirect_to(root_url)
		else	
		@user.destroy
	    flash[:success] = "Пользователь удален."
	    redirect_to users_url
		end
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Изменения сохранены"
			redirect_to @user
		else
		render 'edit'
		end
	end

private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	#Предфильтры

	def signed_in_user
		unless signed_in?
			store_location
			flash[:info] = "Пожалуйста авторизуйтесь"
			redirect_to signin_url
		end
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end

	def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
