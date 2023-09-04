class Ticket < ApplicationRecord

    enum status: [:new_ticket, :pending, :resolved]
    before_destroy :delete_from_csv

    validates_presence_of :name, :email, :subject
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

    has_many :comments, dependent: :destroy

    def save_to_csv
        csv_path = Rails.root.join('tickets.csv')
        CSV.open(csv_path, "a+") do |csv|
            csv << [nil, name, email, subject, content, status]
        end
    end

    def has_non_empty_comments?
        comments.any? { |comment| comment.content.present? }
    end

    def delete_from_csv
        csv_path = Rails.root.join('tickets.csv').to_s
        `sed -i '/^#{self.id},/d' #{csv_path}`
    end

end