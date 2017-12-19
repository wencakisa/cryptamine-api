class AbstractMessagesController < ApplicationController
  before_action :set_rsa
  before_action :set_message, only: :show

  def index
    json_response rsa_messages
  end

  def create
    @message = rsa_messages.create!(message: evaluated_message)
    json_response @message, :created
  end

  def show
    json_response @message
  end

  private
    def set_rsa
      @rsa = Rsa.find params[:rsa_id]
    end

    def set_message
      @message = rsa_messages.find params[:id]
    end

    def message_params
      params.require(:message)
    end

  protected
    # TODO: Check how to make this "abstract" controller a really abstract one, "the Rails way"
    # These two methods should be overriden in children

    def rsa_messages
      raise
    end

    def evaluated_message
      raise
    end
end
