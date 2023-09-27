class AddCreatedByToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :created_by, :integer
  end
end
