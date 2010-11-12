module Paperclip
  class << self
    def logger #:nodoc:
      Rails.logger
    end
  end
end