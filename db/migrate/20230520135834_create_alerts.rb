class CreateAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :alerts, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.uuid :user_id
      t.float :target_price
      t.string :status
      t.string :symbol

      t.timestamps
    end
    add_index :alerts, :user_id
  end
end
