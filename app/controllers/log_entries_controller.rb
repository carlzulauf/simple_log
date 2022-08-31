class LogEntriesController < ApplicationController
  HEADERS_THAT_MATTER = /^HTTP.*|^CONTENT.*|^REMOTE.*|^REQUEST.*|^AUTHORIZATION.*|^SCRIPT.*|^SERVER.*/

  skip_before_action :verify_authenticity_token

  def create
    namespace = Namespace.find_by(uuid: params[:namespace_uuid])
    log_entry = namespace.log_entries.create!(
      headers: all_actual_request_headers.to_json,
      content: request.body.read(65_536),
      content_type: request.headers["Content-Type"],
    )
    NamespaceChannel.broadcast_to namespace, [log_entry.as_shareable_json]
    render json: log_entry.as_shareable_json
  end

  private

  def all_actual_request_headers
    {}.tap do |found|
      request.headers.each do |header, value|
        found[header] = value if header =~ HEADERS_THAT_MATTER
      end
    end
  end
end
