class AddProjectIdToCards < ActiveRecord::Migration
  def change
    add_reference :cards, :project, index: true
    add_foreign_key :cards, :projects
  end
end
