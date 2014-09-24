class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  validates :school, presence: true
end
