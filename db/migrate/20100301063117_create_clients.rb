class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :phone, :null => false
      t.string :email
    end

    add_index :clients, :phone, :unique => true
  end

  def self.down
    drop_table :clients
  end
end
