class CalendarsController < ApplicationController
  before_action :authenticate_user!

  def show
    @time_slots = current_user.time_slots.order(date: :asc, start_time: :asc)
    
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
    @time_slot = TimeSlot.find(params[:id])
    if @time_slot.update(
      status: 'scheduled',
      patient_name: params[:patient_name],
      patient_email: params[:patient_email]
    )
      # TODO: Add email notification here
      redirect_to calendar_path, notice: 'Appointment scheduled successfully!'
    else
      redirect_to calendar_path, alert: 'Failed to schedule appointment.'
    end
  end

  private

  def time_slot_params
    params.require(:time_slot).permit(:date, :start_time, :end_time)
  end
end 