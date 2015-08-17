class AddImagetoOffers < ActiveRecord::Migration
   def self.up
    change_table :offers do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :offers, :avatar
  end
end
