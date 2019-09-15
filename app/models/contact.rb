class Contact < ApplicationRecord
  belongs_to :user

  validates :first_name, :presence => true
  validates :last_name, presence: true 
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A(\w|[.])+[@]\w{3,}[.]\w{2,13}\z/i #e.mail@gmail.com example of validated email. 

  def friendly_updated_at
    updated_at.strftime("%l:%M %p, %b %e, %Y")
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def japanese_phone_number
    "+81 #{phone_number}"
  end
end
