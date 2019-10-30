class Assist < ApplicationRecord
  belongs_to :user
  validates_presence_of :check_in

  scope :completed, -> { where.not(check_in: nil, check_out: nil) }
  scope :today, -> { where(check_in: Date.today.all_day) }
  scope :ordered, -> { order(check_in: :desc) }
  scope :this_month, -> { where(check_in: Time.now.beginning_of_month..
                                          Time.now.end_of_month) }
  scope :last_month, -> { where(check_in: 1.month.ago.beginning_of_month..
                                          1.month.ago.end_of_month) }

  def worked_hours
    TimeDifference.between(self.check_in, self.check_out ).in_hours
  end
end
