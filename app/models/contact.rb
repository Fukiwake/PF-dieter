class Contact < ApplicationRecord
  belongs_to :customer

  enum genre: { demand: 1, good: 2, bad: 3, other: 4 }
end
