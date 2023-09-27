class TicketsController < ApplicationController

    before_action :authenticate_manager!, only: [:index, :update, :destroy]

    def new
        @ticket = Ticket.new
    end

    def index
        @tickets = Ticket.all
        @ticket_counts = Ticket.group(:status).count
    end

    def show
        @ticket = Ticket.find(params[:id])
    end

    def create
        @ticket = Ticket.new(ticket_params)
        @ticket.created_by = current_user.id
        if @ticket.valid?
            @ticket.save_to_csv
            redirect_to tickets_path, notice: 'Ticket was successfully created.'
        else
            render :new
        end
    end
    
    def update
        @ticket = Ticket.find(params[:id])
        if @ticket.update(ticket_params)
            redirect_to tickets_path, notice: 'Ticket was successfully updated.'
        else
            render :edit
        end
    end
    
    def destroy
        @ticket = Ticket.find(params[:id])
        @ticket.destroy
        redirect_to tickets_path, notice: 'Ticket was successfully deleted.'
    end
    
    private
    
    def ticket_params
        params.require(:ticket).permit(:name, :email, :subject, :content, :status, :priority, :assigned_to_id, :created_by)
    end
    
end
