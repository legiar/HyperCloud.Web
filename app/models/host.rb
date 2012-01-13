class Host < ActiveRecord::Base
  belongs_to :zone
  
  validates :name, :presence => true, :uniqueness => true
end
