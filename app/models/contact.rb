class Contact < ApplicationRecord

  enum genre: { demand: 1, good: 2, bad: 3, other: 4 }
end
