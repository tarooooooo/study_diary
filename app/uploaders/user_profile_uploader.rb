class UserProfileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "default.jpg"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process resize_to_fit: [500, 500]
  end

  version :small_thumb do
    process resize_to_fit: [300, 300]
  end
end
