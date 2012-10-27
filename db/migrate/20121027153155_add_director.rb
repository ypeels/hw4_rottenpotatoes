# http://api.rubyonrails.org/classes/ActiveRecord/Migration.html

class AddDirector < ActiveRecord::Migration
  def up
    add_column :movies, :director, :string
  end

  def down
    remove_column :director
  end
end
