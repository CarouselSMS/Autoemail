class AddEmailSubjectToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :email_subject, :string
  end

  def self.down
    remove_column :messages, :email_subject
  end
end
