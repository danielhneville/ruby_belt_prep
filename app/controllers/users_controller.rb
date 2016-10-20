class UsersController < ApplicationController

	before_action :require_login, only: [:update, :edit]
	before_action :require_correct_user, only: [:update, :edit]

  def create
  	u_params = user_params
  	u_params['state'] = State.find(user_params['state_id'].to_i)
    u_params.delete('state_id')
  	@user = User.new( u_params )
  	if @user.save
  		session[:user_id] = @user.id
  		redirect_to events_path
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to new_session_path
  	end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update( user_params )
  		redirect_to events_path
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to :back
  	end
  end

  def edit
  	@user = current_user
  end

  private
  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :email, :city, :state_id, :password, :password_confirmation)
  	end

end
