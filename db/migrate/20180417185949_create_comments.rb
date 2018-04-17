class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :profile
      t.belongs_to :user
      t.string :content
      t.date :created_at, default: Date.today
      t.timestamps null: false
    end
  end
end
