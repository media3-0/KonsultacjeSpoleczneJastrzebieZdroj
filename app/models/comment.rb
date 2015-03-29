class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :consultation

	 has_and_belongs_to_many :comments
end
