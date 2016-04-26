class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :adjustments

  def incomes
    self.adjustments.map { |adj| adj.value > 0 }
  end

  def expenses
    self.adjustments.map { |adj| adj.value < 0 }
  end

  def monthly_net
    self.income - self.costs
  end

end
