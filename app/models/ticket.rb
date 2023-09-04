class Ticket < ApplicationRecord

    enum status: [:new_ticket, :pending, :resolved]

    validates_presence_of :name, :email, :subject
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

    has_many :comments, dependent: :destroy

    def save_to_csv
        CSV.open(Rails.root.join('tickets.csv'), "a+") do |csv|
            csv << [name, email, subject, content, status]
        end
    end

    def has_non_empty_comments?
        comments.any? { |comment| comment.content.present? }
    end
end