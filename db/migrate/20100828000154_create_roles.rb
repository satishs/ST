class CreateRoles < ActiveRecord::Migration
  def self.up
      create_table :roles, :force => true do |t|
        t.column :name, :string
      end

      add_index :roles, :name
      Role.create(:name => "admin")
      Role.create(:name => "beta_tester")
      Role.create(:name => "organization")
      Role.create(:name => "vendor")
      Role.create(:name => "member")
    end

    def self.down
      drop_table :roles
    end
end
