class Usuario < ActiveRecord::Base

  attr_accessor :url_avatar

  belongs_to :imagem_avatar, :class_name => "Imagem", :foreign_key => "imagem_avatar_id"

  include Amistad::FriendModel

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def url_avatar

    verifica_preenchimento_imagem_avatar()

    self.url_avatar = self.imagem_avatar.imagem.url(:medio)
  end

  def obter_avatar

    verifica_preenchimento_imagem_avatar()

    self.imagem_avatar

  end

  def verifica_preenchimento_imagem_avatar

    if self.imagem_avatar.nil?
      self.imagem_avatar = Imagem.new
    end

  end

end
