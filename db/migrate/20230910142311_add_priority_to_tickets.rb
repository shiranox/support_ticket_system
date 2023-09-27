class AddPriorityToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :priority, :integer
  end
end
