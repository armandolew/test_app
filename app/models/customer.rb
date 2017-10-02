class Customer < ActiveRecord::Base

  self.table_name = "customers"
  has_many :customer_bills 

end