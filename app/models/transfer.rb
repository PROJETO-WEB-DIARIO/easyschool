class Transfer < ApplicationRecord
  belongs_to :student
  
  validates :student_id, presence: true
  validates :school_destination, presence: true
  validates :transfer_date, presence: true
end
