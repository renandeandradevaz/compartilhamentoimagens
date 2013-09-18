class Imagem < ActiveRecord::Base

  belongs_to :album

  has_attached_file :imagem, :styles => {:pequeno => "200x200>", :medio => "400x400>", :grande => "800x800>"}, :default_url => "/assets/no-face.jpg"

  def gerar_md5_nome_imagem

    nome_arquivo = self.imagem_file_name.split('.')[0]
    extensao = self.imagem_file_name.split('.')[1]
    self.imagem_file_name = (Digest::MD5.hexdigest nome_arquivo) << "." << extensao

  end

end
