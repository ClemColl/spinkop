class IndefinitionsController < ApplicationController
  before_action :set_indefinition, only: [:show, :edit, :update, :destroy]

  # GET /indefinitions
  # GET /indefinitions.json
  def index
    @indefinitions = Indefinition.all
  end

  # GET /indefinitions/1
  # GET /indefinitions/1.json
  def show
  end

  # GET /indefinitions/new
  def new
    @indefinition = Indefinition.new
  end

  # GET /indefinitions/1/edit
  def edit
  end

  # POST /indefinitions
  # POST /indefinitions.json
  def create
    @indefinition = Indefinition.new(indefinition_params)

    respond_to do |format|
      if @indefinition.save
        format.html { redirect_to @indefinition, notice: 'Indefinition was successfully created.' }
        format.json { render :show, status: :created, location: @indefinition }
      else
        format.html { render :new }
        format.json { render json: @indefinition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /indefinitions/1
  # PATCH/PUT /indefinitions/1.json
  def update
    respond_to do |format|
      if @indefinition.update(indefinition_params)
        format.html { redirect_to @indefinition, notice: 'Indefinition was successfully updated.' }
        format.json { render :show, status: :ok, location: @indefinition }
      else
        format.html { render :edit }
        format.json { render json: @indefinition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indefinitions/1
  # DELETE /indefinitions/1.json
  def destroy
    @indefinition.destroy
    respond_to do |format|
      format.html { redirect_to indefinitions_url, notice: 'Indefinition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_indefinition
      @indefinition = Indefinition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def indefinition_params
      params.require(:indefinition).permit(:name, :description, :auteur)
    end
end
