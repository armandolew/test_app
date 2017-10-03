class CustomerBillSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :customer
end
