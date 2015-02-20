class Project < ActiveRecord::Base
  belongs_to :user
  has_many :cards, -> {order("position")}, dependent: :destroy
  validates_presence_of :title
end
