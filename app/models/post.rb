class Post < ActiveRecord::Base
  scope :find_newest_article, -> { order(created_at: :desc).limit(5) }
end
