class Todo < ApplicationRecord
    belongs_to :user

    def self.to_csv
        attributes = %w{username is_done content user_id}

        CSV.generate(headers: true) do |csv|
          csv << attributes

          all.each do |todo|
            csv << attributes.map{ |attr|
            if attr == 'username'
              attr = todo.user.username
            else
              attr = todo.send(attr)
            end
          }
          end
        end
    end

    def self.import(file,id)
        CSV.foreach(file.path, headers: true) do |row|
            p row
            Todo.create(content: row['content'], user_id: row['user_id'], is_done: row['is_done'])
        end
    end
end
