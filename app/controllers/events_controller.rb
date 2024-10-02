class EventsController < ApplicationController
  before_action :set_event, except: %i[ index new create ]
  verify_authorized

  # GET /events or /events.json
  def index
    authorize!

    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    authorize!

    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    authorize!

    @event = Event.new(event_params)
    @event.organizer = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def register
    registration = current_user.registrations.build(event: @event)

    if registration.save
      redirect_to @event, notice: 'Te has registrado exitosamente para este evento.'
    else
      redirect_to @event, alert: 'Hubo un problema con tu registro.'
    end
  end

  def unregister
    registration = current_user.registrations.find_by(event: @event)

    if registration&.destroy
      redirect_to @event, notice: 'Has cancelado tu registro para este evento.'
    else
      redirect_to @event, alert: 'Hubo un problema al cancelar tu registro.'
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])

      authorize! @event
    end

    def event_params
      params.require(:event).permit(:name, :description, :organizer_id, :venue_id, :date, :price)
    end
end
