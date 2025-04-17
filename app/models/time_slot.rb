class TimeSlot < ApplicationRecord
  belongs_to :user
  belongs_to :calendar

  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :status, presence: true, inclusion: { in: %w[available pending scheduled] }

  validate :end_time_after_start_time
  validate :no_overlap
  validate :not_in_past

  scope :available, -> { where(status: 'available') }
  scope :pending, -> { where(status: 'pending') }
  scope :scheduled, -> { where(status: 'scheduled') }
  scope :upcoming, -> { where('date > ? OR (date = ? AND start_time > ?)', Date.current, Date.current, Time.current.strftime('%H:%M')).order(date: :asc, start_time: :asc) }
  scope :past, -> { where('date < ?', Date.today).order(date: :desc, start_time: :desc) }

  def accept_booking!
    update!(status: 'scheduled')
  end

  def reject_booking!
    update!(
      status: 'available',
      patient_name: nil,
      patient_email: nil
    )
  end

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def no_overlap
    return if date.blank? || start_time.blank? || end_time.blank?

    overlapping_slots = TimeSlot
      .where(date: date, calendar_id: calendar_id)
      .where.not(id: id) # Exclude self when updating
      .where('(start_time < ? AND end_time > ?) OR (start_time < ? AND end_time > ?) OR (start_time >= ? AND end_time <= ?)',
             end_time, start_time, # Slot starts during existing slot
             end_time, end_time,   # Slot ends during existing slot
             start_time, end_time) # Slot completely contains existing slot

    if overlapping_slots.exists?
      errors.add(:base, "This time slot overlaps with an existing appointment")
    end
  end

  def not_in_past
    if date.present? && start_time.present?
      slot_time = Time.zone.parse("#{date} #{start_time.strftime('%H:%M')}")
      if slot_time < Time.current
        errors.add(:base, "Cannot create time slots in the past")
      end
    end
  end
end 