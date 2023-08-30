class Question < ApplicationRecord
  belongs_to :customer

  validates :questions_name, presence: true
  validates :questions_introduction, presence: true

end
