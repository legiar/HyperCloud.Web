class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super
    end
  end

  def active_for_authentication?
    super && approved?
  end

  def valid_for_authentication?
    if confirmed?
      block_given? ? yield : true
    else
      inactive_message
    end
  end
  
  def approve!
    self.approved = true
    save(:validate => true)
    Mailer.approve(self).deliver
  end
  
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end    

end
