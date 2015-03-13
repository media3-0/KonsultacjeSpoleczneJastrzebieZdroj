class Attachment < ActiveRecord::Base

    attr_accessible (previous list), :image
	mount_uploader :image, FileUploader
	
    allows_multi_upload


end
