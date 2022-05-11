class UsersController < ApplicationController

    def new
        @user = User.new
    end


    def edit

        @user = User.find(params[:id])
    end


    def update
        @user = User.find(params[:id])
        
        @user.update(params.require(:user).permit(:username, :email, :password))
        byebug
        if @user.errors.empty?  
            flash[:notice] = "Your account has been updated successfully"
            redirect_to articles_path
        else
            render 'edit'
        end


    end



    def create
        @user = User.new(user_params)
        if(@user.save)
            flash(:notice, "User created successfully")
            redirect_to articles_path
        else
            render 'new'
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end