# == Schema Information
#
# Table name: wikis
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  private    :boolean          default(FALSE)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborations
  has_many :users, through: :collaborations

  scope :visible_to, -> (user) { user ? all : where(private: false) }
  default_scope { order('created_at DESC') }
  
  def public?
    !private
  end
end
