class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update]
  before_filter :authenticate_usuario!

  def index

    @albums = current_usuario.albums

  end

  def new
    @album = Album.new
  end

  def create

    @album = Album.new(album_params)
    @album.usuario = current_usuario

    if @album.save
      salvar_imagens()
    end

    redirect_to @album
  end

  def show

  end

  def edit

  end

  def update
    salvar_imagens()
    redirect_to @album
  end

  def excluir_imagens

    params[:ids_imagens].split(',').each do|id_imagem|

      imagem = Imagem.find(id_imagem)
      imagem.imagem = nil
      imagem.save
      imagem.delete
    end

    render :json => {:status => :ok}

  end

  private
  def album_params
    params.require(:album).permit(:nome)
  end

  def set_album
    @album = Album.find(params[:id])
  end

  def salvar_imagens

    params[:album][:imagens].each do |imagem_temporaria|

      imagem_a_ser_salva = Imagem.new
      imagem_a_ser_salva.imagem = imagem_temporaria.tempfile
      imagem_a_ser_salva.imagem_file_name = imagem_temporaria.original_filename
      imagem_a_ser_salva.album = @album
      imagem_a_ser_salva.gerar_md5_nome_imagem
      imagem_a_ser_salva.save

    end

  end

end

