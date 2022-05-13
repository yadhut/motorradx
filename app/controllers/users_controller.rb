class UsersController < ApplicationController

    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @users = User.paginate(page: params[:page], per_page: 8)
    end
    def new
        @user = User.new
    end


    def show
        @user = User.find(params[:id])
        @articles = @user.articles

    rescue => e
        flash[:error] = "User unavailable!"
        redirect_to users_path
    end


    def edit
        @user = User.find(params[:id])
    end


    def update
        @user = User.find(params[:id])
        
        @user.update(params.require(:user).permit(:username, :email, :password))
        
        if @user.errors.empty?  
            flash[:notice] = "Your account has been updated successfully"
            redirect_to @user
        else
            render 'edit'
        end


    end



    def create
        @user = User.new(user_params)
        if(@user.save)
            flash[:notice] ="User created successfully"
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end

    def destroy
        
        @user = User.find(params[:id])
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:error] ="Profile and all associated articles have been deleted successfully!"
        redirect_to articles_path

    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
        @user = User.find(params[:id])
        if (current_user != @user && !current_user.admin?)
            flash[:error] ="You only allowded to update your profile!"
            redirect_to users_path
        end
    end

end