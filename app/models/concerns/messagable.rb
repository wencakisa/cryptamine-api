module Messagable
  extend ActiveSupport::Concern

  included do
    belongs_to :rsa

    validates_presence_of :message
  end
end
