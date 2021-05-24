# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'
require 'active_support/concern'

require_relative "feodorov_oop_kp/version"


module FeodorovOopKp
  extend ActiveSupport::Autoload

  autoload :App

  class Error < StandardError; end
end
