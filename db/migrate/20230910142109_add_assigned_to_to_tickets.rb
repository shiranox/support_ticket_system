class AddAssignedToToTickets < ActiveRecord::Migration[7.0]
  def change
    add_reference :tickets, :assigned_to, foreign_key: { to_table: :users }
  end
end
