class Site < ActiveRecord::Base
  belongs_to :customer
  belongs_to :database
  belongs_to :slice
  belongs_to :pool
  belongs_to :product
  has_many :site_errors, :foreign_key => :site, :primary_key => :name
  has_many :instances, :class_name => "SiteInstance", :dependent => :destroy, :include => :slice, :order => "slices.name"
  has_many :slices, :through => :instances

  validates :name, :presence => true, :uniqueness => true
  validates :product, :presence => true
  
  before_save :store_old_values
  after_save :populate_instances
  
  private
    
    def store_old_values
      @previously_changed = changes
    end
    
    def populate_instances
      if previous_changes.has_key?("pool_id")
        instances.clear
        pool.slices.each do |slice|
          instances.create(:slice => slice)
        end
      end
    end
    
end
