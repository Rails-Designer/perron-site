class Content::Resource < Perron::Resource
  def self.nested_routes = [:template]

  delegate :name, :command, to: :metadata
  alias_method :title, :name

  def template = File.read(template_path)

  def type
    Type.new(name: TYPES[metadata.type], slug: TYPES[metadata.type].parameterize)
  end
  alias_method :section, :type # this is to get a consistent API with Article

  private

  TYPES = {
    template: "Templates",
    snippet: "Snippets",
    component: "Components",
  }.with_indifferent_access

  def template_path = Rails.root.join("app", "content", "resources", slug, "TEMPLATE")

  Type = Data.define(:name, :slug)
end
