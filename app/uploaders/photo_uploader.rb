class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :aws

  process convert: :png

  before :cache, :save_original_filename

  process :save_content_type_and_size_in_model

  def save_original_filename(file)
    model.original_filename ||= file.original_filename if file.respond_to?(:original_filename)
  end

  def save_content_type_and_size_in_model
    model.content_type = file.content_type if file.content_type
    model.file_size = file.size
  end

  def filename
    # This IF's clauses are here to prevente the override of the name if I run
    # recreate_versions! (https://github.com/jnicklas/carrierwave/wiki/How-to%3A-Create-random-and-unique-filenames-for-all-versioned-files)
    if original_filename
      if model && model.read_attribute(:image).present?
        model.read_attribute(:image)
      else
        @name ||= "#{secure_token}.png"
      end
    end
  end

  def store_dir
    "#{model.owner_type.underscore.pluralize}/#{model.owner_id}/#{model.class.to_s.underscore.pluralize}"
  end

  # Create different versions of your uploaded files:
  version :large do
    process :resize_and_pad => [1600, 1600]
  end
  version :normal do
    process :resize_to_fill => [800, 600]
  end
  version :thumb do
    process :resize_to_fill => [400, 300]
  end

  def extension_white_list
    %w(jpg jpeg gif png bmp)
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end
end
