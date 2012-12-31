class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  # Constants
  MAX_ROUNDS = 3

  # Associations
  has_many :games, :dependent => :destroy
  has_many :materials, :through => :scores
  has_many :scores

  # Validations
  validates :name, :presence => true, :length => { :maximum => 255 }
  validates_email_format_of :email # via gem

  def game_reset!
    if current_game.present?
      current_game.complete!
    else
      self.games.create
    end
  end

  def current_game
    self.games.current.last
  end

  def game_completed?
    (self.materials.count >= MAX_ROUNDS) || Material.next_for(self).nil?
  end
end
