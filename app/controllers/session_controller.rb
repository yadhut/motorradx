class SessionController < ApplicationController

    def new


    end


    def create

        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            flash[:notice] = "Logged in successfully"
            session[:user_id] = user.id
            redirect_to user
        else
            flash.now[:error] = "Thre was a problem with your given input"
            render 'new'
        end
    end


    def destroy
        session[:user_id] = nil
        flash[:notice] = "successfully logged out!"
        redirect_to login_path

    end

end