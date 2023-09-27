class Ticket < ApplicationRecord

    enum status: [:new_ticket, :pending, :resolved]
    enum priority: [:low, :medium, :high, :urgent]
    before_destroy :delete_from_csv

    validates_presence_of :name, :subject

    has_many :comments, dependent: :destroy
    belongs_to :assigned_to, class_name: 'User', optional: true
    belongs_to :creator, class_name: 'User', foreign_key: 'created_by'

    def save_to_csv
        csv_path = Rails.root.join('tickets.csv')
        CSV.open(csv_path, "a+") do |csv|
            csv << [nil, name, subject, content, status, priority, created_by]
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