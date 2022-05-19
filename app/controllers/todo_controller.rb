class TodoController < ApplicationController
    def index
        @todo_all = Todo.where(user_id: current_user.id)
        @todo = Todo.new
    end

    def create

        @todo = Todo.new(params.require(:todo).permit(:content))
        @todo.user_id = current_user.id
        @todo.save
        @todo_all = Todo.where(user_id: current_user.id)
        respond_to do |format|
            format.html { render partial: 'todo_list', locals: {todo: @todo_all} }
         end
    end

    def update
        todo = params[:todo]
        todo_id = todo[:id]
        @todo = Todo.find(todo_id.to_i)
        @todo.is_done =  todo[:is_done]
        @todo.save
        @todo_all = Todo.where(user_id: current_user.id)
        respond_to do |format|
            format.html { render partial: 'todo_list', locals: {todo: @todo_all} }
         end
    end

    def export
        @todo = Todo.where(user_id: current_user.id)
        respond_to do |format|
            format.html
            format.csv { send_data @todo.to_csv, filename: "todo-#{Date.today}.csv" }
        end
    end

    def upload
        @user = current_user.id
         @file = Todo.import(params[:file],current_user.id)
         UserMailer.with(user: @user).success_email.deliver_now
        redirect_to todo_index_path
    end

end
