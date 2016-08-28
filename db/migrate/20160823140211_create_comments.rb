class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references  :user, index: true, foreign_key: true
      t.references  :prototype, index: true, foreign_key: true
      t.text  :text
      t.timestamps
    end
  end
end
