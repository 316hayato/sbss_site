class RequestDetail < ApplicationRecord
  belongs_to :request
  belongs_to :service
end
