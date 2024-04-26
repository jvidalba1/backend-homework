class ApplicationService
  Response = Struct.new(:success?, :payload, :errors) do
    def failure?
      !success?
    end

    def status
      payload[:status] || :ok
    end
  end

  def success(payload = nil)
    Response.new(true, payload)
  end

  def failure(errors, options = {})
    Response.new(false, options, errors)
  end
end
