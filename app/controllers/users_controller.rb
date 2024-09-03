class UsersController <ApplicationController 
  def new 
    @user = User.new()
  end 

  def show 
    @user = User.find(params[:id])
  end 

  def create 
    user = User.create(user_params)
    if user.save
      redirect_to user_path(user)
    else  
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end 

  def login_form
    
  end

  def login_user
    user = User.find_by(email: params[:email]) #hey find me a user with this email
    if user && user.authenticate(params[:password]) #checks if user with email exists and if the password provided matches encrypted password
      session[:user_id] = user.id #sets the session id to the user id
      flash[:success] = "Welcome, #{user.name}"
      # binding.pry
      redirect_to user_path(user)
    else
      flash[:error] = "Invalid email or password"
      render :new
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 