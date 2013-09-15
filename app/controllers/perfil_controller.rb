#encoding: utf-8

class PerfilController < ApplicationController
  before_action :set_usuario, only: [:show, :add, :amigos]
  before_filter :authenticate_usuario!, :except => [:show, :amigos]

  def show

    if (@usuario.imagem_avatar.nil?)
      @usuario.imagem_avatar = Imagem.new
    end

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

    @amizades = Amistad.friendship_class.find_by_sql("select * from friendships f , usuarios u where (f.friendable_id = u.id OR f.friend_id = u.id) and u.name like '%#{params[:id]}%' and (friendable_id=#{session[:id_usuario_selecionado]} OR friend_id=#{session[:id_usuario_selecionado]}) and pending='0' LIMIT 2 OFFSET #{session[:pagina_pesquisa_atual]}")

    idsAmigos = Array.new

    @amizades.each do |amizade|
      if session[:id_usuario_selecionado] != amizade.friend_id
        unless idsAmigos.include?(amizade.friend_id)
          idsAmigos << amizade.friend_id
        end
      else
        unless idsAmigos.include?(amizade.friendable_id)
          idsAmigos << amizade.friendable_id
        end
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
