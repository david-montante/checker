class CreateAssists < ActiveRecord::Migration[5.2]
  def change
    create_table :assists do |t|
      t.references  :user, null: false
      t.datetime    :check_in, null: false
      t.datetime    :check_out

      t.timestamps
    end
  end
end
