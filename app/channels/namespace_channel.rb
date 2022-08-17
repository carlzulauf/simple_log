class NamespaceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    Rails.logger.warn "Connected with #{params.inspect}"
    transmit({succes: true, more: "data"})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def log
  end
end
