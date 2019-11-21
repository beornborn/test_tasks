class ActivityPolicy < ApplicationPolicy
  def list?
    true
  end

  def create?
    (user.is_admin? && !admin_ids.include?(record.user_id)) || record.user_id == user.id
  end

  def destroy?
    create?
  end

  def update?
    create?
  end

  def show?
    create?
  end

  class Scope < Scope
    def resolve
      if user.is_admin?
        user_ids = User.with_any_role(:regular, :manager).pluck(:id) + [user.id]
        scope.where(user_id: user_ids)
      elsif user.is_regular? || user.is_manager?
        scope.where(user: user)
      end
    end
  end

  private

  def admin_ids
    User.with_role(:admin).pluck(:id)
  end
end
