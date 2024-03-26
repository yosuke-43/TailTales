class DogAnswerRelationship < ApplicationRecord
  belongs_to :dog
  belongs_to :answer
end
