class Photo < ActiveRecord::Base
  
  EXTENSIONS = [:jpg, :jpeg, :gif, :png]
  MAX_SIZE   = 20.megabytes

  has_attached_file :photo, :styles => { :thumb => "100x100>" }

end
