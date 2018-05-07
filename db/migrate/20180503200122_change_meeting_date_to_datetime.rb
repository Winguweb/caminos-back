class ChangeMeetingDateToDatetime < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        change_column :meetings, :date, :datetime
      end
      dir.down do
        change_column :meetings, :date, :date
      end
    end
  end
end
