class TodoController < ApplicationController
    def index
        @todo_all = Todo.where(user_id: current_user.id)
        @todo = Todo.new
    end

    def create  
        UserMailer.with(user: @user).welcome_email.deliver_later
        @todo = Todo.new(params.require(:todo).permit(:content))
        @todo.user_id = current_user.id
        @todo.save
        @todo_all = Todo.where(user_id: current_user.id)
        respond_to do |format|
            format.html { render partial: 'todo_list', locals: {todo: @todo_all} }
         end
    end

    def update
        v = params[:todo]
        v = v[:id]
        @todo = Todo.find(v.to_i)
        if @todo.is_done == true
            @todo.is_done = false
        else
            @todo.is_done = true    
        end
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
        @user = current_user
        UserMailer.with(user: @user).success_email.deliver_now
        @file = Todo.import(params[:file],current_user.id)
        redirect_to todo_index_path
    end

end