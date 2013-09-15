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

    @amizades = Amistad.friendship_class.find_by_sql("select * from friendships f , usuarios u where (f.friendable_id = u.id OR f.friend_id = u.id) and u.name like '%#{params[:id]}%' and (friendable_id=#{current_usuario.id} OR friend_id=#{current_usuario.id}) and pending='0' LIMIT 2 OFFSET #{session[:pagina_pesquisa_atual]}")

    idsAmigos = Array.new

    @amizades.each do |amizade|
      if current_usuario.id != amizade.friend_id
        idsAmigos << amizade.friend_id

      else
        idsAmigos << amizade.friendable_id
      end
    end

    @amigos = Array.new

    idsAmigos.each do |idAmigo|
      possivelAmigo = Usuario.find(idAmigo)
      if (possivelAmigo.imagem_avatar.nil?)
        possivelAmigo.imagem_avatar = Imagem.new
      end
      possivelAmigo.url_avatar = possivelAmigo.imagem_avatar.imagem.url(:medio)
      @amigos << possivelAmigo if possivelAmigo.name.downcase.include?(params[:id].downcase)
    end

    render :json => {:status => :ok, :usuarios => @amigos.as_json(:methods => [:url_avatar])}

  end

end
