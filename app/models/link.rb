class Link < ApplicationRecord
    has_many :views, dependent: :destroy
    scope :recent_first, -> { order(created_at: :desc) }

    validates :url, presence: true

    def to_param
        ShortCode.encode(id)
    end

    def self.find(id)
        super ShortCode.decode(id)
    end

    def domain
        URI(url).host rescue StandardError URI::InvalidURIError
    end
end
