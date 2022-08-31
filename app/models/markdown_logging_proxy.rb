# frozen_string_literal: true

require 'logger'
require 'securerandom'
require 'pp'
require 'time'

class MarkdownLoggingProxy
  DONT_OVERWRITE = %i[
    __binding__ == instance_exec != singleton_method_added equal? instance_eval
  ]

  def initialize(target:, logger: nil, location: STDOUT, ignore: [], proxy_response: [])
    @ignore = (ignore + proxy_response).uniq
    @proxy_response = proxy_response
    @target = target
    @logger = logger || __setup_logger(location)
  end

  def method_missing(meth, *args, &blk)
    # @heading_level = 2
    __log :info, meth, 2, <<~MSG
      Calling `#{meth}`

      Arguments:

      #{__inspect_object(args)}

      Block? #{block_given? ? 'Yes' : 'No'}

      Local stack:

      #{caller.grep(/projects/).map { |l| "* #{l.chop}`" }.join("\n")}
    MSG
    # @heading_level = 3

    __proxy_response(meth, @target.public_send(meth, *args, &__proxy_block(meth, blk))).tap do |response|
      __log :info, meth, <<~MSG
        `#{meth}` Response

        #{__inspect_object(response)}
      MSG
    end
  rescue StandardError => e
    __log :error, meth, <<~MSG
      Error in `#{meth}`

      Type: #{e.class}

      #{__inspect_object(e)}
    MSG
    raise e
  end

  # (Object.new.methods - DONT_OVERWRITE).each do |meth|
  %i[to_param].each do |meth|
    define_method(meth) do |*args, &blk|
      method_missing(meth, *args, &blk)
    end
  end

  private

  def __log(level, meth, heading = 3, msg)
    return if @ignore.member?(meth)
    @heading_level = heading
    @logger.send(level, msg)
  end

  def __proxy_response(meth, response)
    return response unless @proxy_response.member?(meth)
    __log :info, nil, <<~MSG
      Using proxied response for `#{meth}`

      Object to proxy:

      #{__inspect_object(response)}
    MSG
    self.class.new(target: response, logger: @logger)
  end

  def __proxy_block(meth, block)
    return if block.nil?
    logger = @logger
    proc do |*args|
      logger.info <<~MSG
        Yield to block in `#{meth}`

        Arguments:

        #{__inspect_object(args)}
      MSG
      block.call(*args).tap do |response|
        logger.info <<~MSG
          Response from block in `#{meth}`

          #{__inspect_object(response)}
        MSG
      end
    end
  end

  def __inspect_object(obj)
    ['```ruby', obj.pretty_inspect.chomp, '```'].join("\n")
  end

  def __setup_logger(log_location)
    Logger.new(log_location).tap do |logger|
      logger.formatter = proc do |severity, time, _, msg|
        "#{'#' * @heading_level} #{severity} in #{Process.pid} at #{time.iso8601} -- #{msg}\n\n"
      end
    end
  end
end
