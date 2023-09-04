class CommentsController < ApplicationController
    
    before_action :authenticate_manager!

    def create
        @ticket = Ticket.find(params[:ticket_id])
        @comment = @ticket.comments.new(comment_params)
        @comment.user = current_user

        if @comment.save
            redirect_to ticket_path(@ticket), notice: 'Comment added successfully!'
        else
            redirect_to ticket_path(@ticket), alert: 'Comment cannot be empty!'
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end
  
end
