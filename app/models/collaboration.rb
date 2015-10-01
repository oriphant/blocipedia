# == Schema Information
#
# Table name: collaborations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  wiki_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Collaboration < ActiveRecord::Base
  has_many :user
  belongs_to :wiki
  
  def self.users
    User.where(id: pluck(:user_id))
  end

  def self.wikis
    Wiki.where(id: pluck(:wiki_id))
  end

  def user
    User.find(user_id)
  end
  
  def wiki
    Wiki.find(wiki_id)
  end
  
end
