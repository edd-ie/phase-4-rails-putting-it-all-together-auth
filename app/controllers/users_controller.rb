class UsersController < ApplicationController
    # before_action :authorize
    # skip_before_action :authorize, only: [:create]
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable


    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] ||= user.id
            render json: user, status: :created            
        else
            render json: {error: user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def show
        user = User.find_by(id: session[:user_id])
        if user
            session[:user_id] ||= user.id
            render json: user, status: :accepted
        else
            render json: {error: "Not authorized"}, status: :unauthorized
        end
    end

    private
    def authorize
        render json: {error: "Not authorized!"}, status: :unauthorized unless session.include? :user_id            
    end

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

    def unprocessable(invalid)
        render json: {error: invalid.errors.full_messages}, status: :unprocessable_entity
    end
end
