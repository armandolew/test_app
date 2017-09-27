class ConnectionService
  def get_connection(url)
    response = HTTParty.get(url)
  end

end