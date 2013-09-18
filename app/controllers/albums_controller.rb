class AlbumsController < ApplicationController
  before_filter :authenticate_usuario!

  def index

  end

  def new
    @album = Album.new
  end

  def create

    album = Album.new(album_params)
    album.usuario = current_usuario

    if album.save

      params[:album][:imagens].each do |imagem_temporaria|

        imagem_a_ser_salva = Imagem.new
        imagem_a_ser_salva.imagem = imagem_temporaria.tempfile
        imagem_a_ser_salva.imagem_file_name = imagem_temporaria.original_filename
        imagem_a_ser_salva.album = album
        imagem_a_ser_salva.gerar_md5_nome_imagem
        imagem_a_ser_salva.save

      end
    end
  end

  private
  def album_params
    params.require(:album).permit(:nome)
  end

end

