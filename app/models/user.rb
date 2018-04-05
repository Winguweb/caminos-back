class User < ApplicationRecord
  include SoftDestroy
  include RoleModel

  has_one :profile, dependent: :destroy
  belongs_to :entity, polymorphic: true, optional: true

  AVAILABLE_ROLES = [:admin, :ambassador].freeze
  private_constant :AVAILABLE_ROLES

  FALLBACK_COLORS = [ '#34495e', '#9b59b6', '#3498db', '#2ecc71', '#1abc9c', '#3498db',
                      '#f1c40f', '#e67e22', '#e74c3c', '#95a5a6', '#16a085', '#27ae60',
                      '#2980b9', '#8e44ad', '#2c3e50', '#f39c12', '#d35400', '#c0392b',
                      '#7f8c8d' ].freeze
  private_constant :FALLBACK_COLORS

  attribute :settings, :jsonb, default: {}

  validates_presence_of :email, :username
  validates_presence_of :password, on: [ :create ]

  roles AVAILABLE_ROLES

  alias_attribute :name, :first_name
  delegate :first_name, :last_name, :full_name, :initials, to: :profile

  acts_as_authentic do |authlogic|
    authlogic.login_field = :email
    authlogic.ignore_blank_passwords = true
    authlogic.require_password_confirmation = false
    authlogic.validates_format_of_email_field_options = { with: Authlogic::Regex.email_nonascii }
    authlogic.validates_length_of_password_field_options = { on: :create, minimum: 8 }
  end

  def self.available_roles
    AVAILABLE_ROLES
  end

  def avatar_url
    "//www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?default=404"
  end

  def color
    FALLBACK_COLORS[id.to_i % FALLBACK_COLORS.length]
  end

  def soft_destroy?
    false
  end
end
