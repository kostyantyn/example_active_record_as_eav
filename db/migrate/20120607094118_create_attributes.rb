class CreateAttributes < ActiveRecord::Migration
  def change
    %w(string integer float boolean).each do |type|
      create_table "#{type}_attributes" do |t|
        t.references :entity, polymorphic: true
        t.string :name
        t.send type, :value
        t.timestamps
      end
    end
  end
end
