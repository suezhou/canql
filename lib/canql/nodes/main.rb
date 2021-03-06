# frozen_string_literal: true

# require 'active_support/core_ext/object/blank'

module Canql #:nodoc: all
  module Nodes
    module RecordCountNode
      def meta_data_item
        { 'limit' => { Canql::EQUALS => number.text_value.to_i } }
      end
    end
  end
end

module Canql #:nodoc: all
  module Nodes
    # Provides meta data for with conditions that return
    # multiple instances of a condition type as an array
    module WithConditions
      def meta_data_item
        conditions = {}
        anomalies = []
        genetic_tests = []
        test_results = []

        post.elements.each do |element|
          anomalies << element.to_anomaly if element.respond_to?(:to_anomaly)
          genetic_tests << element.to_genetic_test if element.respond_to?(:to_genetic_test)
          test_results << element.to_test_result if element.respond_to?(:to_test_result)
        end

        conditions['anomalies'] = { Canql::ALL => anomalies } if anomalies.any?
        conditions['genetic_tests'] = { Canql::ALL => genetic_tests } if genetic_tests.any?
        conditions['test_results'] = { Canql::ALL => test_results } if test_results.any?
        conditions
      end
    end
  end
end
