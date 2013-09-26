class FotosController < ApplicationController
  before_filter :authenticate_usuario!

  def show

    @imagem = Imagem.find(params[:id])

  end

  def comentar

    comentario = Comentario.new
    comentario.comentario =  params[:comentario]
    comentario.usuario = current_usuario
    comentario.imagem = Imagem.find(params[:id_imagem])
    comentario.save

    render :json => {:status => :ok, :comentario => comentario}

  end

end

