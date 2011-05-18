class Host < ActiveRecord::Base
  set_inheritance_column :ruby_type
  validates :name, :presence => true, :uniqueness => true
end
