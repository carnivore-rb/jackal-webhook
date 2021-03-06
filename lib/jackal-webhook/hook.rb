require 'jackal-webhook'

class Jackal::Webhook::Hook < Jackal::Utils::HttpApi; end

Jackal::Webhook::Hook.define do
  post %r{/(v\d+)/([^/]+)/?(.*)} do |msg, path, version, action, extras, *args|
    begin
      result = msg[:message][:body]
      info "Request received for `#{action}` (#{version}). Processing to pipeline."
      payload = new_payload(
        config.fetch(:job_name, action),
        Smash.new(
          action => result,
          :webhook => {
            :version => version,
            :action => action,
            :path_extra => extras,
            :headers => msg[:message][:headers],
            :query => msg[:message][:query]
          }
        )
      )
      debug "Delivering new payload into pipeline: #{payload.inspect}"
      Carnivore::Supervisor.supervisor[:jackal_webhook_output].transmit(payload)
      msg.confirm!(
        :response_body => MultiJson.dump(
          :job_id => payload[:id],
          :message => 'Request received!'
        ),
        :code => :ok
      )
    rescue => e
      error "Failed to receive webhook payload due to unexpected error! (#{e})"
      debug "Failed webhook request: #{e.class}: #{e}\n#{e.backtrace.join("\n")}"
      msg.confirm!(
        :response_body => MultiJson.dump(
          :error => true,
          :message => 'Failed to process request. Unknown error encountered!'
        ),
        :code => :internal_server_error
      )
    end
  end
end
