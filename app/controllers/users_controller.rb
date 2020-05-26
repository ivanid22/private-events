class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @upcoming_events = @user.upcoming_events
    @prev_events = @user.previous_events
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        session[:logged_in_user_name] = @user.name
        format.html { redirect_to events_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }

      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def sign_in_view
    render :sign_in_view
  end

  def sign_in
    name = params[:name]
    @user = User.find_by(name: name)
    if @user
      session[:logged_in_user_name] = @user.name
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:notice] = 'Invalid user name'
      render :sign_in_view
    end
  end

  def sign_out
    session[:logged_in_user_name] = nil
    session[:user_id] = nil
    redirect_to events_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :address)
  end
end
