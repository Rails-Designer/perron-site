class Content::Resource < Perron::Resource
  include Templates

  def self.nested_routes = [ :template ]

  search_fields :description, :category, :collection_name

  TYPES = {
    component: "Components",
    snippet: "Snippets",
    template: "Templates"
  }.with_indifferent_access

  DESCRIPTIONS = {
    template: "Complete HTML templates for pages, site sections and full websites",
    snippet: "Code snippets to inject functionality into your site",
    component: "Static site specific UI components"
  }.with_indifferent_access

  delegate :type, :title, :description, :category, :command, to: :metadata
  alias_method :name, :title

  scope :by_type, ->(type) { where(type: type) }

  validates :title, :description, presence: true
  validates :type, inclusion: { in: TYPES.keys }

  def resource_type
    Type.new(name: TYPES[metadata.type], description: DESCRIPTIONS[metadata.type], slug: TYPES[metadata.type].parameterize)
  end
  alias_method :article_section, :resource_type # required for a consistent API with Content::Article

  def images
    base_path = Rails.root.join("app", "content", "resources", slug, "images")

    Dir.glob(File.join(base_path, "**", "*"))
      .reject { File.directory?(it) || it =~ /\.+$/ }
      .map { it.delete_prefix("#{base_path}/") }
  end

  def position = metadata.position || Float::INFINITY

  def collection_name = "Library"

  private

  Type = Data.define(:name, :description, :slug)
end
