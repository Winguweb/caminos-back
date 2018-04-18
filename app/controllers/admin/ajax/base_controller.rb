module Admin::Ajax
  class BaseController < Admin::BaseController
    layout false
    before_action :set_json_default_response_format

    protected

    def set_json_default_response_format
      request.format = :json
    end
  end
end
