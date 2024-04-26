# frozen_string_literal: true

module AcknowledgesHelper
  def checked_knowledge_source(area)
    @acknowledge.knowledge_source.nil? ? false : @acknowledge.knowledge_source.match(area)
  end
end
