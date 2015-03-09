class Ticket < ActiveRecord::Base
  DEPARTMENTS = ['payments', 'technical_issues', 'other']
  SELECT_DEPARTMENTS = DEPARTMENTS.map { |s| [s.capitalize, s] }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :department, presence: true, :inclusion => { :in => DEPARTMENTS }
  validates :subject, presence: true
  validates :description, presence: true
end
