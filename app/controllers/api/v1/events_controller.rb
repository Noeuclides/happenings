class Api::V1::EventsController < Api::ApplicationController
  before_action :authenticate_request
  before_action :set_event, only: %i[ show update destroy ]

  # GET /api/v1/events or /api/v1/events.json
  def index
    authorize!

    @events = Event.all
    render json: @events
  end

  # GET /api/v1/events/1 or /api/v1/events/1.json
  def show
    render json: @event
  end

  # POST /api/v1/events or /api/v1/events.json
  def create
    authorize!

    @event = Event.new(event_params)
    @event.organizer = current_user

    if @event.save
      render json: @event, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/events/1 or /api/v1/events/1.json
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/events/1 or /api/v1/events/1.json
  def destroy
    @event.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])

    authorize! @event
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:name, :description, :organizer_id, :venue_id, :date, :price)
  end
end
