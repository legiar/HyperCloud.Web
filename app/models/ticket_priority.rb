class TicketPriority < ActiveRecord::Base
  has_many :tickets
  
  scope :enabled, where(:disabled_at => nil).order(:name)
  scope :disabled, where('disabled_at is not null').order(:name)
  scope :default, where('lower(name) = ?', 'medium').limit(1)

  validates :name, :presence => true, :uniqueness => true

  def enabled?
    disabled_at.blank?
  end
  
  def standard?
    %w(high medium low).include?(self.name.downcase)
  end  
end
