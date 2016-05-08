class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :adjustments

  def income
    self.adjustments.select { |adj| adj.value > 0 }
  end

  def expenses
    self.adjustments.select { |adj| adj.value <= 0 }
  end

  def total_income
    total = 0
    self.income.each do |inc|
      if inc.date?
        total += inc.value * (1.month / inc.duration) if inc.duration <= 1.month
      else
        total += inc.value
      end
    end
    total
  end

  def total_expenses
    total = 0
    self.expenses.each do |exp|
      if exp.date?
        total += exp.value * (1.month / exp.duration) if exp.duration <= 1.month
      else
        total += exp.value
      end
    end
    total.abs
  end

  def monthly_net
    self.total_income - self.total_expenses
  end
end
