class HomeController < ApplicationController
  before_action :set_usuario, only: [:update]
  before_filter :authenticate_usuario!

  def index
    @solicitacoes_amizades = current_usuario.pending_invited_by
  end

  def aceitar_amizade
    current_usuario.approve Usuario.where(atalho: params[:id]).take!
    render :json => {:status => :ok, :informacao => "Sucesso"}
  end

  def recusar_amizade
    current_usuario.remove_friendship Usuario.where(atalho: params[:id]).take!
    render :json => {:status => :ok, :informacao => "Sucesso"}
  end

  def alterarInformacoesPessoais
    @usuario = current_usuario
  end

  def alterar_avatar
    @imagem = Imagem.new
  end

  def salvar_avatar

    imagem = Imagem.new(imagem_params)
    imagem.gerar_md5_nome_imagem()
    imagem.save

    if(!current_usuario.imagem_avatar.nil?)
      current_usuario.imagem_avatar.imagem = nil
      current_usuario.imagem_avatar.save
      current_usuario.imagem_avatar.delete
    end

    current_usuario.imagem_avatar = imagem
    current_usuario.save

    redirect_to action: 'index'

  end

  def update
    if @usuario.update(usuario_params)
      redirect_to action: 'index'
    else
      render action: 'alterarInformacoesPessoais'
    end
  end

  private
  def set_usuario
    @usuario = Usuario.find(current_usuario[:id])
  end

  def usuario_params
    params.require(:usuario).permit(:name, :informacoesPessoais, :atalho)
  end

  def imagem_params
    params.require(:imagem).permit(:imagem)
  end

end
