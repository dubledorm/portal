class User < ApplicationRecord
  include UserConcern

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :services, :dependent => :destroy
  has_one_attached :avatar
end
