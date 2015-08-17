class AddAttachmentAvatarToOffers < ActiveRecord::Migration
  def change
     def self.up
    change_table :offers do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :offers, :avatar
  end
  end
end
