class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :verify_user, only: [:show, :edit, :update, :destroy]

  # GET /lists or /lists.json
  def index
    @lists = current_user.lists
  end

  # GET /lists/1 or /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists or /lists.json
  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id

    respond_to do |format|
      if @list.save
        format.html { redirect_to list_url(@list), notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    puts list_params
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to list_url(@list), notice: "List was successfully updated." }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    if current_user == @list.user
        @list.destroy
    end

    respond_to do |format|
      format.html { redirect_to lists_url, notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
        @list = List.find_by_id(params[:id])
        if @list.nil?
            redirect_to lists_path
        end
        @list
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:title, :description, :completed, list_items_attributes: [:id, :name, :qty, :item_type, :completed])
    end

    def verify_user
       redirect_to lists_path, notice: "You cannot edit that list" if @list.user != current_user
    end
end
