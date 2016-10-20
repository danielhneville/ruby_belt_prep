class RsvpsController < ApplicationController
  def create
  	r_params = rsvp_params
  	r_params['user'] = current_user
  	r_params['event'] = Event.find( rsvp_params['event'].to_i )
  	@rsvp = Rsvp.new( r_params )
  	if @rsvp.save
  		redirect_to events_path
  	else
  		flash[:errors]
  		redirect_to events_path
  	end
  end

  def destroy
  	Rsvp.find(params[:id]).destroy if Rsvp.find(params[:id]).user == current_user
  	redirect_to events_path
  end

  private
  	def rsvp_params
  		params.require(:rsvp).permit(:user, :event)
  	end

end
