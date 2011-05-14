class Condition < ActiveRecord::Base
  belongs_to :job

  scope :create_model, lambda{|model| where(:model => model).where(:event_type => 0)}
  scope :update_model, lambda{|model,fields| where(:model => model).where(:event_type => 1).where(:fields => fields)}
  scope :destroy_model, lambda{|model| where(:model => model).where(:event_type => 2)}
end
