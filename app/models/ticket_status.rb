class TicketStatus < ActiveRecord::Base
  has_many :tickets
  
  scope :open, where('lower(name) = ?', 'open').limit(1)
  scope :closed, where('lower(name) = ?', 'closed').limit(1)
  scope :enabled, where(:disabled_at => nil).order(:name)
  scope :disabled, where('disabled_at is not null').order(:name)

  validates :name, :presence => true, :uniqueness => true

  def enabled?
    disabled_at.blank?
  end
  
end
