class StudentSerializer < ActiveModel::Serializer
  attributes :name, :major, :age
  belongs_to :instructor
end
