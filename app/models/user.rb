# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string
#

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

  def signed_up_as_premium?
    role == 'signed_up_as_premium'
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


  private
  def set_default_role
    self.role||= 'basic'
  end

end
