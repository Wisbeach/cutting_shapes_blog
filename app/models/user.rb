class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts

  def is_admin?
    # Implement logic to determine if user is an admin
    role == 'admin' # Example for role-based check
    # self.id == your_user_id # Example for specific user ID check
  end

end
