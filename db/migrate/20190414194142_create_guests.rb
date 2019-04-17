class CreateGuests < ActiveRecord::Migration[5.2]

  def change
    create_table :guests do |t|
      t.string :username
      t.integer :guest_total
  end
end

end

