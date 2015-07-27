class CreateArtistinfos < ActiveRecord::Migration
  def change
    create_table :artistinfos do |t|
      t.references :user
      t.string :artistname

      t.timestamps null: false
    end
    add_index("artistinfos","user_id")
  end
end
