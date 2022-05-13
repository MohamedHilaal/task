class TodoController < ApplicationController
    def index
        @todo_all = Todo.where(users_id: current_user.id)
        @todo = Todo.new
        
    end
    def create
        
        @todo = Todo.new(params.require(:todo).permit(:content))
        @todo.users_id = current_user.id
        @todo.save
        @todo_all = Todo.where(users_id: current_user.id)
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
        @todo_all = Todo.where(users_id: current_user.id)
        respond_to do |format|
            format.html { render partial: 'todo_list', locals: {todo: @todo_all} }
         end

    end



end