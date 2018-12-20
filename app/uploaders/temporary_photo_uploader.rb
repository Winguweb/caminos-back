class TemporaryPhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :aws

  process convert: :png

  def filename
    @name ||= "#{secure_token}.png"
  end

  def store_dir
    "tmp"
  end

  def extension_white_list
    %w(jpg jpeg gif png bmp)
  end

  protected

  def secure_token
    SecureRandom.uuid
  end
end
