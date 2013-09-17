class AlbumsController < ApplicationController
  before_filter :authenticate_usuario!

  def index

  end

  def new
    @album = Album.new
  end

  def create

    params[:album][:imagens].each do |x|

      puts x

    end

  end

end

