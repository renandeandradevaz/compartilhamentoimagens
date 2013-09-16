#encoding: utf-8

class PerfilController < ApplicationController
  before_action :set_usuario, only: [:show, :add, :amigos]
  before_filter :authenticate_usuario!, :except => [:show, :amigos]

  def show

  end

  def add
    current_usuario.invite @usuario
    @notice = "O convite de amizade foi enviado. Aguarde a confirmação"
    render action: 'show'
  end

  def amigos
    session[:id_usuario_selecionado] = @usuario.id
  end

  def auto_complete_amigos
    session[:pagina_pesquisa_atual] = 0
    buscar_amigos
  end

  def carregar_mais_amigos
    session[:pagina_pesquisa_atual] = session[:pagina_pesquisa_atual] + 1
    buscar_amigos
  end

  private
  def set_usuario
    @usuario = Usuario.where(atalho: params[:id]).take!
  end

  def buscar_amigos

    @amigos = Usuario.find(session[:id_usuario_selecionado]).friends.where("name like ?", "%#{params[:id]}%").page(session[:pagina_pesquisa_atual]).per(1)

    render :json => {:status => :ok, :usuarios => @amigos.as_json(:methods => [:url_avatar])}

  end

end
