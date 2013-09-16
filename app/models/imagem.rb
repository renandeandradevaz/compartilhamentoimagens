class Imagem < ActiveRecord::Base

  has_attached_file :imagem, :styles => {:medio => "400x400>", :grande => "800x800>"}, :default_url => "/assets/no-face.jpg"

end
