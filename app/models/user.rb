class User < ApplicationRecord
    has_secure_password

    enum role: [:regular, :manager]
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

end