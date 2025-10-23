class Content::Resource < Perron::Resource
  include Templates

  TYPES = {
    template: "Templates",
    snippet: "Snippets",
    component: "Components"
  }.with_indifferent_access

  def self.nested_routes = [ :template ]

  delegate :type, :title, :description, :command, to: :metadata
  alias_method :name, :title

  validates :title, :description, presence: true
  validates :type, inclusion: { in: TYPES }

  def resource_type
    Type.new(name: TYPES[metadata.type], slug: TYPES[metadata.type].parameterize)
  end
  alias_method :article_section, :resource_type # required for a consistent API with Content::Article

  def images
    base_path = Rails.root.join("app", "content", "resources", slug, "images")

    Dir.glob(File.join(base_path, "**", "*"))
      .reject { File.directory?(it) || it =~ /\.+$/ }
      .map { it.delete_prefix("#{base_path}/") }
  end

  private

  Type = Data.define(:name, :slug)
end
