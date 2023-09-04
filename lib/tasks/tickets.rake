desc "Read CSV file with tickets saved and insert to db"
task :read_csv_to_db => :environment do
  require "csv"
  CSV.foreach("tickets.csv", headers:true) do |row|
    existing_ticket = Ticket.find_by(
      name: row[0],
      email: row[1],
      subject: row[2],
      content: row[3],
    )

    unless existing_ticket
      attributes = {
        name: row[0],
        email: row[1],
        subject: row[2],
        content: row[3],
        status: row[4]
      }
      Ticket.create(attributes)
    end
  end
end