class UserPolicy < ApplicationPolicy
  def list?
    user.is_manager? || user.is_admin?
  end

  def destroy?
    (record.is_regular? && user.is_manager?) || (!record.is_admin? && user.is_admin?)
  end

  def update?
    record.id == user.id || destroy?
  end

  def show?
    update?
  end

  class Scope < Scope
    def resolve
      if user.is_admin?
        scope.order(id: :desc).includes(:roles).without_role(:admin).all
      elsif user.is_manager?
        scope.order(id: :desc).includes(:roles).with_role(:regular)
      end
    end
  end
end
