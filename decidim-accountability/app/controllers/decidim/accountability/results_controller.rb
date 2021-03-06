# frozen_string_literal: true

module Decidim
  module Accountability
    # Exposes the result resource so users can view them
    class ResultsController < Decidim::Accountability::ApplicationController
      include FilterResource
      helper Decidim::WidgetUrlsHelper
      helper Decidim::TraceabilityHelper
      helper Decidim::Accountability::BreadcrumbHelper

      helper_method :results, :result, :first_class_categories, :count_calculator

      private

      def results
        parent_id = params[:parent_id].presence
        @results ||= search.results.where(parent_id: parent_id).page(params[:page]).per(12)
      end

      def result
        @result ||= Result.includes(:timeline_entries).where(feature: current_feature).find(params[:id])
      end

      def search_klass
        ResultSearch
      end

      def default_filter_params
        {
          search_text: "",
          scope_id: "",
          category_id: ""
        }
      end

      def context_params
        { feature: current_feature, organization: current_organization }
      end

      def first_class_categories
        @first_class_categories ||= current_participatory_space.categories.first_class
      end

      def count_calculator(scope_id, category_id)
        Decidim::Accountability::ResultsCalculator.new(current_feature, scope_id, category_id).count
      end
    end
  end
end
