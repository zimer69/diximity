class BookingMailer < ApplicationMailer
  def booking_accepted_to_patient(time_slot)
    @time_slot = time_slot
    @video_call_link = "https://meet.diximity.com/#{SecureRandom.hex(8)}"
    mail(
      to: @time_slot.patient_email,
      subject: "Your appointment has been confirmed!"
    )
  end

  def booking_accepted_to_user(time_slot)
    @time_slot = time_slot
    @video_call_link = "https://meet.diximity.com/#{SecureRandom.hex(8)}"
    mail(
      to: @time_slot.user.email,
      subject: "You have confirmed an appointment"
    )
  end

  def booking_cancelled_to_patient(time_slot, cancellation_message)
    @time_slot = time_slot
    @cancellation_message = cancellation_message
    @user = time_slot.user

    Rails.logger.info "Attempting to send cancellation email to: #{time_slot.patient_email}"
    Rails.logger.info "Time slot details: #{time_slot.inspect}"
    Rails.logger.info "User details: #{@user.inspect}"

    mail(
      to: time_slot.patient_email,
      subject: "Your appointment has been cancelled"
    )
  end
end 