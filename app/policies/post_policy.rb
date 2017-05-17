class PostPolicy < ApplicationPolicy

  def update?
    (record.user_id == user.id && !record.approved?) || user.is_admin?
  end

  def destroy?
    update?
  end

end