class EventsController < ApplicationController
  before_action :set_event, :only => [:show, :edit, :update, :destroy, :dashboard]

  def index
    if params[:keyword]
      @events = Event.where(["name like ?", "%#{params[:keyword]}%"])
    else
      @events = Event.all
    end
    sort_by = (params[:order] == 'name') ? 'name' : 'created_at'
    @events = Event.order(sort_by).page(params[:page]).per(2)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_url
      flash[:notice] = "event was successfully created"
    else
      render :action => :new
    end
  end

  def show
    @page_title = @event.name
  end

  def update
    if @event.update(event_params)
      redirect_to event_url(@event)
      flash[:notice] = "event was successfully updated"
    else
      render :action => :edit
    end
  end

  def edit
  end

  def destroy
    @event.destroy
    flash[:alert] = "event was successfully deleted"
    redirect_to :action => :index
  end

  def latest
    @events = Event.order("id desc").limit(3)
  end

  def bulk_delete
    Event.destroy_all
    redirect_to events_path
  end

  def bulk_update
    ids = Array(params[:ids])
    events = ids.map { |i| Event.find_by_id(i) }.compact

    if params[:commit] == "Publish"
      events.each{ |e| e.update(:status => "published") }
    elsif params[:commit] == "Delete"
      events.each { |e| e.destroy  }
    end

    redirect_to events_url
  end

  def dashboard
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :description, :category_id,
      :location_attributes => [:id, :name, :_destroy], :group_ids => [])
    end
end
