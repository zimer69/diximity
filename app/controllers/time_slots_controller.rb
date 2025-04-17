class TimeSlotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_time_slot, only: [:update, :destroy, :accept_booking, :reject_booking, :cancel_booking]

  def create
    @time_slot = current_user.time_slots.build(time_slot_params)
    @time_slot.calendar = current_user.calendar || current_user.create_calendar
    @time_slot.status = 'available'
    
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

  def accept_booking
    if @time_slot.status == 'pending'
      @time_slot.accept_booking!
      
      # Send confirmation emails
      BookingMailer.booking_accepted_to_patient(@time_slot).deliver_later
      BookingMailer.booking_accepted_to_user(@time_slot).deliver_later
      
      redirect_to calendar_path(@time_slot.calendar), notice: 'Booking has been accepted successfully. Confirmation emails have been sent.'
    else
      redirect_to calendar_path(@time_slot.calendar), alert: 'This booking cannot be accepted.'
    end
  end

  def reject_booking
    if @time_slot.status == 'pending'
      @time_slot.reject_booking!
      redirect_to calendar_path(@time_slot.calendar), notice: 'Booking has been rejected successfully.'
    else
      redirect_to calendar_path(@time_slot.calendar), alert: 'This booking cannot be rejected.'
    end
  end

  def cancel_booking
    if @time_slot.status == 'scheduled'
      # Send cancellation email with the message before updating the time slot
      BookingMailer.booking_cancelled_to_patient(@time_slot, params[:cancellation_message]).deliver_later
      
      @time_slot.cancel_booking!
      
      redirect_to calendar_path, notice: 'Booking has been cancelled successfully. Notification has been sent to the patient.'
    else
      redirect_to calendar_path, alert: 'This booking cannot be cancelled.'
    end
  end

  private

  def set_time_slot
    @time_slot = TimeSlot.find(params[:id])
  end

  def time_slot_params
    params.require(:time_slot).permit(:date, :start_time, :end_time, :status, :patient_name, :patient_email)
  end
end 