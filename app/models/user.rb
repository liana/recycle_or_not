class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  # Associations
  has_many :games, :dependent => :destroy
  has_many :materials, :through => :score

  # Validations
  validates :name, :presence => true, :length => { :maximum => 255 }
  validates_email_format_of :email # via gem
end
