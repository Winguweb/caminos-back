# Load the Rails application.
require_relative 'application'

APP_CONFIG = YAML.load_file(File.expand_path('../caminos.yml', __FILE__))
MAP = YAML.load_file(File.expand_path('../map.yml', __FILE__))

# Initialize the Rails application.
Rails.application.initialize!
