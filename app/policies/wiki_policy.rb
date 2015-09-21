class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    (!record.private? && user.present?) || record.user==user || user.admin?
  end
end