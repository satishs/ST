class User < ActiveRecord::Base
  
  has_many :posts
  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles

  validates_presence_of :fullname
  
  acts_as_authentic do |c|
    c.login_field = :email
  end
  
  def member?
    has_role?("member")
  end

  def non_member?
    has_role?("non_member")
  end

  def admin?
    has_role?("admin")
  end

  def has_role?(role)
    self.roles.count(:conditions => ["name = ?", role]) > 0
  end

	def add_role(role)
	  return if self.has_role?(role)
	  self.roles << Role.find_by_name(role)
	end  
end
