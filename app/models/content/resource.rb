class Content::Resource < Perron::Resource
  def self.nested_routes = [:template]

  delegate :type, :name, :command, to: :metadata

  def template = File.read(template_path)

  private

  def template_path = Rails.root.join("app", "content", "resources", slug, "TEMPLATE")
end
