class SessionController < ApplicationController
   skip_before_filter :verify_authenticity_token, :only => [:create]

  def index
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if @current_user != nil
      redirect_to "/dashboard"
    end
  end

  def create    
    user = User.find_by password: params[:password], email: params[:email]
    if user != nil
      session[:user_id] = user.id
      redirect_to dashboard_path, :notice => "Bem vindo #{user.name} ^_^"
    else
      redirect_to "/log_in", :alert => "Usuário ou Senha Invalidos"     
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

  def recover    
  end

  def recover_mail
    user = User.find_by email: params[:email]
    if user != nil
      user.password = SecureRandom.urlsafe_base64(6,false)
      user.save
      redirect_to "/", :notice => "Um e-mail foi enviado com sua nova senha"
    else
      redirect_to :back, :alert => "E-mail não cadastrado"     
    end
  end
  
end