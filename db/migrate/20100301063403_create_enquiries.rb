class CreateEnquiries < ActiveRecord::Migration
  def self.up
    create_table :enquiries do |t|
      t.references :client,   :null => false
      t.references :message,  :null => false
      t.timestamps
    end
    
    add_index :enquiries, :client_id
    add_index :enquiries, :message_id
  end

  def self.down
    drop_table :enquiries
  end
end
