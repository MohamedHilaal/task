desc 'Running through sample test'

task todo: :environment do
    filename = File.join Rails.root, "todo.csv"
    @todo_all = Todo.where(user_id: current_user.id).take

    CSV.foreach(filename) do |row|
        todo = Todo.create(content: row, user_id: @todo_all )
    end
    pp 'Everything Working perfectly'
end