class RsasController < ApplicationController
  before_action :set_rsa, only: :show

  def index
    @rsas = Rsa.all
    # See app/controllers/concerns/response.rb
    json_response @rsas
  end

  def create
    # Use create! in order to throw exception when validation fails
    @rsa = Rsa.create!(rsa_params)
    json_response @rsa, :created
  end

  def show
    json_response @rsa
  end

  def new_keys
    json_response Rsa.new_keys
  end

  private
    def set_rsa
      @rsa = Rsa.find params[:id]
    end

    def rsa_params
      params.permit(:n, :e, :d)
    end
end
