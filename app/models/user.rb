class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :location, :username, :password, :password_confirmation, :remember_me
  
  # Validations
  validates :username, :presence => true, :uniqueness => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :location, :presence => true
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def self.search(search)
    if search
      where("first_name LIKE ? or last_name LIKE ?", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end
