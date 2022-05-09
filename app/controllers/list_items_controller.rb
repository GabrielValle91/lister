class ListItemsController < ApplicationController
  before_action :set_list_item, only: %i[ show edit update destroy ]
  before_action :verify_user, only: [:create, :update, :destroy]

  # GET /list_items or /list_items.json
  def index
    redirect_to lists_path
  end

  # GET /list_items/1 or /list_items/1.json
  def show
  end

  # GET /list_items/new
  def new
    @list_item = ListItem.new
  end

  # GET /list_items/1/edit
  def edit
  end

  # POST /list_items or /list_items.json
  def create
    @list_item = ListItem.new(list_item_params)

    respond_to do |format|
      if @list_item.save
        format.html { redirect_to edit_list_url(@list_item.list_id), notice: "List item was successfully created." }
        format.json { render :show, status: :created, location: @list_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /list_items/1 or /list_items/1.json
  def update
    debugger
    respond_to do |format|
      if @list_item.update(list_item_params)
        format.html { redirect_to edit_list_url(@list_item.list_id), notice: "List item was successfully updated." }
        format.json { render :show, status: :ok, location: @list_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_items/1 or /list_items/1.json
  def destroy
    @list_item.destroy

    respond_to do |format|
      format.html { redirect_to list_items_url, notice: "List item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list_item
      @list_item = ListItem.find_by_id(params[:id])
      if @list_item.nil?
        redirect_to lists_url(params[:list_id])
      end
      @list_item
    end

    # Only allow a list of trusted parameters through.
    def list_item_params
      params.require(:list_item).permit(:name, :item_type, :qty, :completed, :list_id)
    end

    def verify_user
        if @list_item
            redirect_to lists_path, notice: "You cannot access that list item" if @list_item.list.user != current_user
        end 
     end
end
