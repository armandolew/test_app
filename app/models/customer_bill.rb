class CustomerBill < ActiveRecord::Base

  self.table_name = "customer_bills"
  belongs_to :customer

end