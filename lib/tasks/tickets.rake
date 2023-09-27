desc "Read CSV file with tickets saved and insert to db"
task :read_csv_to_db => :environment do
  require "csv"

  csv_path = Rails.root.join('tickets.csv')
  table = CSV.read(csv_path, headers: true)
  modified_file = false
  
  debugger
  table.each_with_index do |row, index|
    next if row[0]
    attributes = {
      name: row[1],
      subject: row[2],
      content: row[3],
      status: row[4],
      priority: row[5],
      created_by: row[6]
    }

    ticket = Ticket.create(attributes)
    table[index][0] = ticket.id
    modified_file = true
  end

  if modified_file
    CSV.open(csv_path, "w") do |csv|
      csv << ["id", "name", "subject", "content", "status", "priorities[priority]", "created_by"]
      table.each do |row|
        csv << row
      end
    end
  end
end
