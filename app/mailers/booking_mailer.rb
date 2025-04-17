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
end 