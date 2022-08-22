class NamespaceChannel < ApplicationCable::Channel
  def subscribed
    namespace = Namespace.find_by(uuid: params[:uuid])
    stream_from "namespace:#{namespace.uuid}" if namespace
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
