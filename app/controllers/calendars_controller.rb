class CalendarsController < ApplicationController
  before_action :authenticate_user!, except: [:schedule]

  def show
    @calendar = current_user.calendar || current_user.create_calendar
    @time_slots = @calendar.time_slots.upcoming
    
    respond_to do |format|
      format.html
      format.json do
        events = @time_slots.map do |slot|
          {
            id: slot.id,
            title: slot.status == 'scheduled' ? "Scheduled: #{slot.patient_name}" : 'Available',
            start: "#{slot.date.to_s}T#{slot.start_time.strftime('%H:%M')}",
            end: "#{slot.date.to_s}T#{slot.end_time.strftime('%H:%M')}",
            extendedProps: {
              status: slot.status,
              patient_name: slot.patient_name,
              patient_email: slot.patient_email
            }
          }
        end
        render json: events
      end
    end
  end

  def schedule
    @time_slot = TimeSlot.find(params[:time_slot_id])
    if @time_slot.update(
      status: 'pending',
      patient_name: params[:name],
      patient_email: params[:email]
    )
      # TODO: Add email notification here
      redirect_back fallback_location: root_path, notice: 'Appointment scheduled request sent successfully! If confirmed, you will receive an email.'
    else
      redirect_back fallback_location: root_path, alert: 'Failed to schedule appointment.'
    end
  end

  private

  def time_slot_params
    params.require(:time_slot).permit(:date, :start_time, :end_time)
  end
end 