class UserMailer < ApplicationMailer
    default from: 'todo@gmail.com'

    def success_email
        @user = params[:user]
        @userId = User.where(id: @user).take
        @url  = 'http://example.com/login'
        mail(to: @userId.email, subject: 'Todo List')
    end
end
