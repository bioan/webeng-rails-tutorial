class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    # render json: @users.to_json(only: [:email, :name], methods: :odd_name), status: :created, location: @user
    render json: UserSerializer.new(@user).serializable_hash, status: :ok, location: @user
  end

  # GET /users/1
  def show
    # render json: @user.to_json(only: [:email, :name], methods: :odd_name)
    render json: UserSerializer.new(@user).serializable_hash, status: :ok, location: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      # render json: @user, status: :created, location: @user
      # render json: @user.to_json(only: [:email, :name], methods: :odd_name), status: :created, location: @user
      render json: UserSerializer(@user).serializable_hash, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      # render json: @user.to_json(only: [:email, :name], methods: :odd_name)
      render json: UserSerializer(@user).serializable_hash, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :name)
    end

end
