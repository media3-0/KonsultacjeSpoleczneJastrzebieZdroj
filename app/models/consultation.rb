class Consultation < ActiveRecord::Base

mount_uploader :file, FileUploader

validates :title, presence: true

	
end
