class UserMailer < ApplicationMailer
    default from: 'todo@gmail.com'

    def success_email
        @user = params[:user]
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: 'Todo List')
    end
end
