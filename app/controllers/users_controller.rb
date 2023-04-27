class UsersController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :render_user_errors
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    
    # def create
    #     user = User.create(strong_params)
    #     if user.valid?
    #         session[:user_id] = user.id
    #         render json: user, status: :created
    #     else
    #         render json: {errors: user.errors.full_messages }, status: :unprocessable_entity
    #     end
    # end

    # def show
    #     user = User.find_by(id: session[:user_id])
    #     if user
    #         render json: user, status: :created
    #     else
    #         render json: {error: "unauthorized"}, status: :unauthorized
    #     end
    # end

    def create
        user = User.create!(strong_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end
    
    def show
        user = User.find(session[:user_id])
        render json: user, status: :created
    end
    

    private

    def strong_params
        params.permit(:username, :password, :img_url, :bio, :password_confirmation)
    end

    def render_user_errors(instance)
        render json: {errors: instance.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found
        render json: { error: "unauthorized" }, status: :unauthorized
    end

 
end