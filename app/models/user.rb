class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :wikis
  has_many :collaborations

  #Use this to set a default role 
  #- http://stackoverflow.com/questions/995593/what-does-or-equals-mean-in-ruby
  #- https://github.com/plataformatec/devise/wiki/How-To:-Add-a-default-role-to-a-User

  before_create :set_default_role 

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def basic?
    role == 'basic'
  end
  
  def upgrade_acct
    self.update_attributes(role: 'premium')
  end

  def downgrade_acct
    self.update_attributes(role: 'basic')
    self.wikis.where(private: true).update_all(private: false)
  end

  def collaborations
    Collaboration.where(user_id: id)
  end

  def wikis
    # Wiki.where(id: collaborations.pluck(:wiki_id))
    collaborations.wikis
  end

  private
  def set_default_role
    self.role||= 'basic'
  end

end
