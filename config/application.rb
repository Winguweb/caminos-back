require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CaminosBack
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # In order to eager load stuff in the lib folder
    config.eager_load_paths << Rails.root.join('lib')

    # In order to load all the locales tree
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml')]

    # In order to use by default the id: :uuid when using the generators
    config.generators do |generator|
      generator.orm :active_record, primary_key_type: :uuid
    end

    # Do not automatically include the all the helpers on the controllers
    config.action_controller.include_all_helpers = false

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.cells.with_assets = %w(
      elements/add_button_cell
      elements/avatar_cell
      elements/breadcrumbs_cell
      elements/button_cell
      elements/description_cell
      elements/documents_table_cell
      elements/map_cell
      elements/meeting_details_cell
      elements/neighborhood_card_cell
      elements/neighborhoods_list_cell
      elements/person_card_cell
      elements/users_table_cell
      elements/work_details_cell
      elements/works_table_cell
      forms/user_cell
      page/header_cell
      section/footer_link_cell
    )
  end
end
