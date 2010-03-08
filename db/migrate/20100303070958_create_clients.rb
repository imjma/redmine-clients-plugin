class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.column :project_id, :integer
      t.column :office_id, :integer
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :email, :string
      t.column :mobile, :string
      t.column :phone, :string
      t.timestamps
    end

    add_column :issues, :client_id, :integer
  end

  def self.down
    drop_table :clients
  end
end
