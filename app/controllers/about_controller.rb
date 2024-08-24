# frozen_string_literal: true

class AboutController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }

  def index
  end

  def who_we_are
  end

  def manual
  end

  def license
  end

  def thank_you_notes
  end

  def privacy_policy
  end

  def friends
  end

  def contact
  end

  def source_code_license
  end

  def how_to_register
  end
end
