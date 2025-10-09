class Content::Article < Perron::Resource
  def self.sections
    SECTIONS.map { |section_data| Section.new(key: section_data.first, name: section_data.second, resources: Content::Article.all.select { it.metadata.section == section_data.first }.sort_by(&:order)) }
  end

  delegate :order, :title, :description, to: :metadata

  validates :section, :title, :description, presence: true
  validates :order, numericality: { greater_than_or_equal_to: 1 }

  def section
    Section.new(key: metadata.section, name: SECTIONS[metadata.section], resources: Content::Article.all.select { it.metadata.section == metadata.section }.sort_by(&:order))
  end

  private

  SECTIONS = {
    getting_started: "Getting started",
    content: "Content",
    metadata: "Metadata"
  }.with_indifferent_access

  Section = Data.define(:key, :name, :resources)
end
