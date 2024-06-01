class Car < ApplicationRecord

    COLORS = %w[red blue green yellow black white].freeze

    attr
    validates :title, presence: true
    validates :make, presence: true
end
