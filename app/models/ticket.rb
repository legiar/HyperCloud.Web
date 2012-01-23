class Ticket < ActiveRecord::Base
  belongs_to :group, :class_name => "TicketGroup"
  belongs_to :status, :class_name => "TicketStatus"
  belongs_to :priority, :class_name => "TicketPriority"
  belongs_to :author, :class_name => "User"
  belongs_to :owner, :class_name => "User"
  has_many :comments, :dependent => :destroy
  
  validates :title, :presence => true 
  validates :group, :presence => true 
  validates :status, :presence => true 
  validates :priority, :presence => true
  
  after_initialize :set_default_values
  before_update :set_closed_at
  
  # Scopes
  scope :not_closed, :joins => :status, :conditions => ['statuses.name <> ?', 'Closed']
  scope :recently_assigned_to, lambda { | user_id | { :limit => 5, :conditions => { :owned_by => user_id }, :include => [:creator, :owner, :group, :status, :priority, :contact], :order => 'updated_at DESC' } }
  scope :active_tickets, :limit => 5, :include => [:creator, :owner, :group, :status, :priority], :order => 'updated_at DESC'
  scope :closed_tickets, :limit => 5, :joins => :status, :include => [:creator, :owner, :group, :status, :priority], :conditions => ['statuses.name = ?', 'Closed'], :order => 'closed_at DESC'
  
  def self.timeline_opened_tickets
    #self.count(:group => 'date(created_at)', :having => ['date(created_at) >= ? and date(created_at) <= ?', (Time.zone.now.beginning_of_day - 30.days).to_date.to_s, (Time.zone.now.end_of_day - 1.day).to_date.to_s])
    self.where('created_at >= ? and created_at <= ?',  Time.zone.now.beginning_of_day - 30.days, Time.zone.now.end_of_day - 1.day).group('created_at').count
  end
  
  def self.timeline_closed_tickets
    #self.count(:group => 'date(closed_at)', :having => ['date(closed_at) >= ? and date(closed_at) <= ?', (Time.zone.now.beginning_of_day - 30.days).to_date.to_s, (Time.zone.now.end_of_day - 1.day).to_date.to_s])
    self.where('closed_at >= ? and closed_at <= ?',  Time.zone.now.beginning_of_day - 30.days, Time.zone.now.end_of_day - 1.day).group('closed_at').count
  end

  def closed?
    status.name.downcase == 'closed'
  end

  def only_touched?
    self.changed.size == 1 and self.changed[0] == "updated_at"
  end

  protected

    def set_default_values
      if new_record?
        # TODO: Normalize default values
        self.group = TicketGroup.enabled.first
        self.priority = TicketPriority.default.first
        self.author = current_user
      end
    end

    def set_closed_at
      if closed?
        self.closed_at = DateTime.now if self.closed_at.nil?
      else
        self.closed_at = nil unless self.closed_at.nil?
      end
    end    
end
