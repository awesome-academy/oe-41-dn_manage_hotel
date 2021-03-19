class User < ApplicationRecord
  enum role: {customer: 0, admin: 1, staff: 2}
  has_secure_password
end
