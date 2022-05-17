class Todo < ApplicationRecord 
    belongs_to :user    

    def self.to_csv
        attributes = %w{content id}
    
        CSV.generate(headers: true) do |csv|
          csv << attributes
    
          all.each do |todo|
            csv << attributes.map{ |attr| todo.send(attr) }
          end
        end
    end

    def self.import(file,id)
        CSV.foreach(file.path, headers: true) do |row|
            p row
            Todo.create(content: row['content'], user_id: id)
        end
    end
end