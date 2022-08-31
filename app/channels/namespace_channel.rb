class NamespaceChannel < ApplicationCable::Channel
  def subscribed
    namespace = Namespace.find_by(uuid: params[:uuid])
    transmit_existing_log_entries(namespace)
    # redis key: "namespace:#{namespace.to_gid_param}"
    stream_for namespace if namespace
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def transmit_existing_log_entries(namespace)
    return if namespace.log_entries.none?
    transmit namespace.log_entries.limit(1000).map(&:as_shareable_json)
  end
end
