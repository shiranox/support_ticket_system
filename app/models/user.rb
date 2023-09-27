class User < ApplicationRecord
    has_secure_password
    has_many :assigned_tickets, foreign_key: :assigned_to_id
    has_many :created_tickets, class_name: 'Ticket', foreign_key: :created_by
    enum role: [:regular, :manager]
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

end