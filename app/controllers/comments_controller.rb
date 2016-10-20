class CommentsController < ApplicationController
  def create
  	c_params = comment_params
  	c_params['user'] = current_user
  	c_params['event'] = Event.find(comment_params['event'].to_i)
  	@comment = Comment.new( c_params )
  	if @comment.save
  		redirect_to :back
  	else
  		flash[:errors] = @comment.errors.full_messages
  		redirect_to :back
  	end
  end

  private
  	def comment_params
  		params.require(:comment).permit(:content, :event)
  	end
end
