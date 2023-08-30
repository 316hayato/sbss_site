class Request < ApplicationRecord
  belongs_to :customer
  has_many :service_details, dependent: :destroy
  
end
