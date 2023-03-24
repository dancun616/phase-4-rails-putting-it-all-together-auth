class SessionsController < ApplicationController

  def create
      user = User.find_by(username: params[:username])
      if user&.authenticate(params[:password])
          session[:user_id] = user.id
          render json: user
      else
          render json: {errors: ["User invalid", "Password invalid"]}, status: :unauthorized
      end
  end

  def destroy
      return render json: {errors: ["User not found", "kindly log in"]}, status: :unauthorized unless session.include? :user_id
      session.delete :user_id
      head:no_content
  end
end