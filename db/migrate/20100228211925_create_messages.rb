class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string  :keyword, :null => false
      t.string  :sms_body
      t.text    :email_body

      t.timestamps
    end
    
    add_index :messages, :keyword, :unique => true
  end

  def self.down
    drop_table :messages
  end
end
