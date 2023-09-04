class User < ApplicationRecord
    has_secure_password

    enum role: [:regular, :manager]
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true
    validates :password_confirmation, presence: true

end