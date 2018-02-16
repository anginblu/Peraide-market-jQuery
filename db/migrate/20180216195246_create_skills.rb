class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.text :description
      t.belongs_to :category
      t.belongs_to :profile
      t.timestamps null: false
    end
  end
end
