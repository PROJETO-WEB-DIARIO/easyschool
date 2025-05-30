class Student < ApplicationRecord
  has_many :enrollments
  has_many :classrooms, through: :enrollments
end
