require 'benchmark'

module RedisLogstash
  module ActionControllerExt

    def redis_logstash

      original_params = get_original_params
      original_flash = get_original_flash

      yield

      begin
        custom_logs = {
            controller: params[:controller],
            action: params[:action],
            email: try_current_user_email,
            params: original_params,
            flash: original_flash,
            response_code: response.status,
            response_message: response.message
        }
        RedisLogstash::Logger.write(custom_logs)
      rescue
        Rails.logger.info "[CUSTOM LOGS NOT SAVED]: #{custom_logs.to_json}"
      end


    end

    def try_current_user_email
      current_user.email rescue ''
    end

    def get_original_params
      path_params = request.path_parameters
      request.params.clone.except(*path_params.keys)
    end

    def get_original_flash
      request.flash.clone
    end

  end
end