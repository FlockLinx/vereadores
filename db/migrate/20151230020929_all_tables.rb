class AllTables < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.column :name, :string
    end

    create_table :cities do |t|
      t.column :name, :string, limit: 60
      t.column :tse_id, :string
      t.belongs_to :state, index: true
    end

    create_table :coalitions do |t|
      t.column :tse_id, :string
      t.column :content, :string
      t.column :acronym, :string, limit: 15
      t.column :name, :string
      t.timestamps
    end

    create_table :parties do |t|
      t.column :number, :integer
      t.column :acronym, :string, limit: 15
      t.column :name, :string
      t.timestamps
    end

    create_table :coalition_parties do |t|
      t.belongs_to :coalition, index: true
      t.belongs_to :party, index: true
    end

    create_table :politians do |t|
      t.column :cpf, :string
      t.column :name, :string
      t.column :birth_date, :date
      t.column :gender, :string, limit: 2
      t.column :nationality, :string
      t.column :birth_city_id, :integer
      t.column :voter_number, :string
       t.timestamps
    end

    create_table :jobs do |t|
      t.column :tse_id, :string
      t.column :name, :string
       t.timestamps
    end

    create_table :education_levels do |t|
      t.column :tse_id, :string
      t.column :name, :string
       t.timestamps
    end

    create_table :elections do |t|
      t.column :year, :string
      t.column :name, :string
       t.timestamps
    end

    create_table "status_applications", force: true do |t|
      t.string   "tse_id"
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "status_results", force: true do |t|
      t.string   "tse_id"
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "civil_statuses", force: true do |t|
      t.string   "tse_id"
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table :campaings do |t|
      t.belongs_to :coalition, index: true
      t.belongs_to :party, index: true
      t.belongs_to :job, index: true
      t.belongs_to :politian, index: true
      t.belongs_to :city, index: true
      t.belongs_to :education_level, index: true
      t.belongs_to :civil_status, index: true
      t.belongs_to :status_application, index: true
      t.belongs_to :status_result, index: true

      t.belongs_to :election, index: true
      t.column :generate_date, :date
      t.column :tse_id, :string
      t.column :budget, :integer
      t.column :number, :string
      t.column :name_campain, :string
      t.timestamps
    end

  end
end
