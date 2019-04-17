class RemoveColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column(:guests, :guest_total)
  end
end
