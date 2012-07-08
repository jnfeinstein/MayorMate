class User < ActiveRecord::Base
  attr_accessible :access_token
  has_many :checkins, :dependent => :destroy
end
