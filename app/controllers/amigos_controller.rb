class AmigosController < ApplicationController
  before_filter :authenticate_usuario!

  def index

  end

  def auto_complete_meus_amigos

    session[:pagina_pesquisa_atual] = 0
    buscar_amigos
  end

  def carregar_mais_amigos
    session[:pagina_pesquisa_atual] = session[:pagina_pesquisa_atual] + 1
    buscar_amigos
  end

  private
  def buscar_amigos

    @amigos = current_usuario.friends.where("name like ?", "%#{params[:id]}%").page(session[:pagina_pesquisa_atual]).per(1)

    render :json => {:status => :ok, :usuarios => @amigos.as_json(:methods => [:url_avatar])}

  end

end
