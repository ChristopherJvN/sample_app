class Micropost < ActiveRecord::Base
  belongs_to :user
validates :user_id, presence: true
validates :content, presence: true
validates :content, length: { maximum: 140 },
                    presence: true
default_scope -> { order(created_at: :desc) }                    
end
