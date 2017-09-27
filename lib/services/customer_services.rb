class CustomerServices

  def get_customer_balance
  	response = HTTParty.get('http://localhost:3000')
  end

end