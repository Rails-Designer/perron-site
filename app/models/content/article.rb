class Content::Article < Perron::Resource
  include Adjacency

  search_fields :description, :collection_name

  SECTIONS = {
    getting_started: "Getting started",
    content: "Content",
    metadata: "Metadata"
  }.with_indifferent_access

  def self.sections
    SECTIONS.map do |key, name|
      Section.new(
        key: key,
        name: name,
        resources: where(section: key).order(:position)
      )
    end
  end

  delegate :section, :position, :title, :description, to: :metadata

  validates :title, :description, presence: true
  validates :section, inclusion: { in: SECTIONS.keys }
  validates :position, numericality: { greater_than_or_equal_to: 1 }

  def article_section
    Section.new(
      key: metadata.section,
      name: SECTIONS[metadata.section],
      resources: self.class.where(section: metadata.section).order(:position)
    )
  end

  def collection_name = "Docs"

  private

  Section = Data.define(:key, :name, :resources)
end
