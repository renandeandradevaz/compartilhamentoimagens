Compartilhamentoimagens::Application.routes.draw do

  devise_for :usuarios

  root to: 'index#index'

  get "home/alterarInformacoesPessoais"
  get "home/alterar_avatar"

  get "fotos/comentar"

  resources :home do
   member do
    get :aceitar_amizade
    get :recusar_amizade
   end
  end

  match 'pesquisa_usuarios/auto_complete_todos_usuarios', to: 'pesquisa_usuarios#auto_complete_todos_usuarios', via: [:get, :post]
  match 'pesquisa_usuarios/carregar_mais_usuarios', to: 'pesquisa_usuarios#carregar_mais_usuarios', via: [:get, :post]

  match 'amigos/auto_complete_meus_amigos', to: 'amigos#auto_complete_meus_amigos', via: [:get, :post]
  match 'amigos/carregar_mais_amigos', to: 'amigos#carregar_mais_amigos', via: [:get, :post]

  match 'perfil/auto_complete_amigos', to: 'perfil#auto_complete_amigos', via: [:get, :post]
  match 'perfil/carregar_mais_amigos', to: 'perfil#carregar_mais_amigos', via: [:get, :post]
  match 'perfil/:id/add', to: 'perfil#add', via: [:get, :post]
  match 'perfil/:id/amigos', to: 'perfil#amigos', via: [:get, :post]

  match 'home/salvar_avatar', to: 'home#salvar_avatar', via: [:get, :post]

  match 'albums/excluir_imagens', to: 'albums#excluir_imagens', via: [:get, :post]

  resources :home
  resources :perfil
  resources :index
  resources :pesquisa_usuarios
  resources :amigos
  resources :albums
  resources :fotos

end
