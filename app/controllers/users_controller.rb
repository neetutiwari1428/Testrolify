class UsersController < ApplicationController
    def index
        @users = User.order(created_at: :desc)
    end
    def new
        @user = User.new(params[:id])
    end
    def create
        @user = User.new(user_params)

        respond_to do |format|
        if @user.save
            format.html { redirect_to @user, notice: 'Post was successfully created.' }
        else
            format.html { render action: "new" }
        end
        end
    end
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to users_url ,notice: "Succesfully updated"
        else
            render :edit
        end
    end
    def show
        @user = User.find(params[:id]) 
    end
    def edit
        @user = User.find(params[:id])
    end
    private
    def user_params
        params.require(:user).permit(:email,:password)
    end
end
