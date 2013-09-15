class Usuario < ActiveRecord::Base


  attr_accessor :url_avatar

  belongs_to :imagem_avatar, :class_name => "Imagem", :foreign_key => "imagem_avatar_id"

  include Amistad::FriendModel

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
