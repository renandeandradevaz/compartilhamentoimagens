class Album < ActiveRecord::Base

  belongs_to :usuario
  has_many :imagems

end
