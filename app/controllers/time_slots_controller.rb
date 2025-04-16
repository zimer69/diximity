class TimeSlotsController < ApplicationController
  before_action :authenticate_user!

  def create
    @time_slot = current_user.time_slots.build(time_slot_params)
    @time_slot.calendar = current_user.calendar || current_user.create_calendar
    
    if @time_slot.save
      redirect_to calendar_path, notice: 'Time slot was successfully created.'
    else
      redirect_to calendar_path, alert: @time_slot.errors.full_messages.join(', ')
    end
  end

  def update
    @time_slot = current_user.time_slots.find(params[:id])
    
    if @time_slot.update(time_slot_params)
      redirect_to calendar_path, notice: 'Time slot was successfully updated.'
    else
      redirect_to calendar_path, alert: 'Failed to update time slot.'
    end
  end

  def destroy
    @time_slot = current_user.time_slots.find(params[:id])
    @time_slot.destroy
    
    redirect_to calendar_path, notice: 'Time slot was successfully deleted.'
  end

  private

  def time_slot_params
    params.require(:time_slot).permit(:date, :start_time, :end_time, :status)
  end
end 