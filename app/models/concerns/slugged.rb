module Slugged
  extend ActiveSupport::Concern

  included do
    def to_param
      id.to_s + "-" + name_or_title.parameterize
    end

    def name_or_title
      return name if self.respond_to?(:name) && name.present?
      return title if self.respond_to?(:title) && title.present?
      return slug if self.respond_to?(:slug) && slug.present?
      ""
    end
  end
end
