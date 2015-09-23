class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborations
  scope :visible_to, -> (user) { user ? all : where(private: false) }
  default_scope { order('created_at DESC') }

  def collaborations
    Collaboration.where(wiki_id: id)
  end

  def users
    # Wiki.where(id: collaborations.pluck(:user_id))
    collaborations.users
  end

end
