class AccessCode < ActiveRecord::Base
  belongs_to :user
  attr_accessible :code
end
