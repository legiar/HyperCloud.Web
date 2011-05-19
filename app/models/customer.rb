class Customer < ActiveRecord::Base
  has_many :databases
  has_many :sites

  validates :name, :presence => true, :uniqueness => true
  validates :type, :presence => true

  set_inheritance_column :ruby_type

  after_initialize do
    if new_record?
      self.type = "NATIVE"
    end
  end
end
