class Wiki < ActiveRecord::Base
  belongs_to :user
  scope :visible_to, -> (user) { user ? all : where(private: false) }
  default_scope { order('created_at DESC') }
end
