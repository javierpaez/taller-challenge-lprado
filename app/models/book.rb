class Book < ApplicationRecord
    STATUSES = %i[available checked_out reserved]
    
    validates :title, :author, :publication_date, presence: true
    validates :rating, numericality: true, inclusion: { in: 0..5  }, allow_nil: true
    validates :status, inclusion: { in: STATUSES }, allow_nil: true
end
