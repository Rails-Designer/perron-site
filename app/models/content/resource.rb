class Content::Resource < Perron::Resource
  include Templates

  TYPES = {
    template: "Templates",
    snippet: "Snippets",
    component: "Components"
  }.with_indifferent_access

  DESCRIPTIONS = {
    template: "Complete HTML templates for pages, site sections and full websites",
    snippet: "Code snippets to inject functionality into your site",
    component: "Static site specific UI components"
  }.with_indifferent_access

  def self.nested_routes = [ :template ]

  delegate :type, :title, :description, :category, :command, to: :metadata
  alias_method :name, :title

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

  def order = metadata.order || 5

  private

  Type = Data.define(:name, :description, :slug)
end
