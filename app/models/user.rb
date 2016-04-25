class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable
end
