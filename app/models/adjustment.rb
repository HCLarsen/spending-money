class Adjustment < ActiveRecord::Base
  belongs_to :user

  enum frequency: ["Days", "Weeks", "Months", "Years"]
  enum income_or_expense: ["Income", "Expense"]

  def date?
    !date.nil?
  end

  def duration
    self.frequency_num.send self.frequency.downcase
  end
end
