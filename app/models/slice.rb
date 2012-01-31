class Slice < ActiveRecord::Base
  
  belongs_to :host
  belongs_to :last_host, :class_name => 'Host'
  belongs_to :network_address
  belongs_to :pool
  
  has_many :site_instances, :dependent => :destroy
  has_many :sites, :through => :site_instances, :dependent => :destroy 

  validates :name, :presence => true, :uniqueness => true
  
  before_save :store_old_values
  after_save :populate_instances
  
  private
  
    def store_old_values
      @previously_changed = changes
    end
  
    def populate_instances
      if previous_changes.has_key?("pool_id")
        sites.clear
        pool.sites.each do |site|
          site_instances.create(:site => site)
        end
      end
    end
    
end
