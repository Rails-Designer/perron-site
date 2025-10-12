class Content::Resource < Perron::Resource
  TYPES = {
    template: "Templates",
    snippet: "Snippets",
    component: "Components",
  }.with_indifferent_access

  def self.nested_routes = [:template]

  delegate :type, :name, :description, :command, to: :metadata
  alias_method :title, :name

  validates :name, :description, presence: true
  validates :type, inclusion: { in: TYPES }

  def template = File.read(template_path)

  def resource_type
    Type.new(name: TYPES[metadata.type], slug: TYPES[metadata.type].parameterize)
  end
  alias_method :article_section, :resource_type # required for a consistent API with Content::Article

  private

  def template_path = Rails.root.join("app", "content", "resources", slug, "TEMPLATE")

  Type = Data.define(:name, :slug)
end
