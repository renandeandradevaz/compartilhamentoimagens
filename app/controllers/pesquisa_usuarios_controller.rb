class PesquisaUsuariosController < ApplicationController

  def index
  end

  def auto_complete_todos_usuarios
    session[:pagina_pesquisa_atual] = 1
    buscar_usuarios
  end

  def carregar_mais_usuarios
    session[:pagina_pesquisa_atual] = session[:pagina_pesquisa_atual] + 1
    buscar_usuarios
  end

  private
  def buscar_usuarios
    @usuarios = Usuario.where("name like ?", "%#{params[:id]}%").page(session[:pagina_pesquisa_atual]).per(1)

    @usuarios.each do |usuario|
      if (usuario.imagem_avatar.nil?)
        usuario.imagem_avatar = Imagem.new
      end
      usuario.url_avatar = usuario.imagem_avatar.imagem.url(:medio)
    end

    render :json => {:status => :ok, :usuarios => @usuarios.as_json(:methods => [:url_avatar])}
  end

end
