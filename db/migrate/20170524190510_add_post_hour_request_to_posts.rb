class AddPostHourRequestToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :overtime_request, :decimal, precision: 5, scale: 2, default: 0.0
  end
end
