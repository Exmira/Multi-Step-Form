class CarsController < ApplicationController
  before_action :set_car, only: %i[ show edit update destroy ]

  # GET /cars or /cars.json
  def index
    @cars = Car.all
  end


  def next_step
    if params[:id]
      @car = Car.find(params[:id])
      @car.assign_attributes(car_params)
    else
      @car = Car.new(car_params)
    end
    step = params[:step].to_i
    
    # Validate only the current step's attributes
    if @car.title.present?
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("step#{step}", render_to_string(partial: "step#{step + 1}", locals: { car: @car }))
        }
      end
    else
      # If the current step's attributes are not valid, render the current step again
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("step#{step}", render_to_string(partial: "step#{step}", locals: { car: @car }))
        }
      end
    end
  end
  
  

  def previous_step
    step = params[:step].to_i

      @car = Car.new(car_params)
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("step#{step}", render_to_string(partial: "step#{step - 1}", locals: { car: @car }))
        }
    end
  end
  

  def update_colors
    @car = Car.new(car_params)
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace("color_select", partial: "color_select", locals: { car: @car })
      }
    end
  end


  # GET /cars/1 or /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars or /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to car_url(@car), notice: "Car was successfully created." }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1 or /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to car_url(@car), notice: "Car was successfully updated." }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1 or /cars/1.json
  def destroy
    @car.destroy!

    respond_to do |format|
      format.html { redirect_to cars_url, notice: "Car was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:title, :make, :color)
    end
end
