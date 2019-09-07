class Goal < ApplicationRecord
end
class Goal < ApplicationRecord
  validates :title,
            presence: true,
            length: { maximum: 80 }

  validates :description,
            presence: true,
            length: { maximum: 500 }

  validates :due_date,
            presence: true

  validate :due_date_cannot_be_in_the_past, :due_date_year_cannot_be_more_than_allowable, if: :due_date_changed?
  validate :check_tatle

  enum priority: { low: 0, medium: 1, high: 2 }
  scope :completed, -> { where(complete: true) }
  scope :todays, -> { where(due_date: Time.zone.today + 1.day) }
  private

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Time.zone.today
      errors.add(:due_date, 'cannot be earlier than today')
    end
  end

  def due_date_year_cannot_be_more_than_allowable
    if due_date.present? && due_date.to_date.year > 2100
      errors.add(:due_date, "a year cannot be more than 2100")
    end
  end
  def check_tatle
    if  title == 'Goal'
      errors.add(:title, "error")
    end
  end
end
