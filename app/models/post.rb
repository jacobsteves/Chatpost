class Post < ActiveRecord::Base
  belongs_to :user
  scope :page, ->  (page) { limit(20).offset(20 * page.to_i) }
end
