# See the Pagy documentation: https://ddnexus.github.io/pagy/extras/i18n
# encoding: utf-8
# frozen_string_literal: true

class Pagy
  # Use ::I18n gem
  module Frontend

    ::I18n.load_path += Dir[Pagy.root.join('locales', '*.yml')]

    Pagy::I18n.clear.instance_eval { undef :load; undef :t } # unload the pagy default constant for efficiency

    alias :pagy_without_i18n :pagy_t
    def pagy_t_with_i18n(*args) ::I18n.t(*args) end
    alias :pagy_t :pagy_t_with_i18n

    # Return example: "Displaying Products 41-60 of 324 in total"
    def pagy_collection_info(pagy)
      path = if (count = pagy.count) == 0 ; 'pagy.collection_info.no_items'
             else pagy.pages == 1 ? 'pagy.collection_info.single_page' : 'pagy.collection_info.multiple_pages'
             end
      collection_item = pagy_t(pagy.vars[:collection_path], count: count)
      pagy_t(path, collection_item: collection_item, count: count, from: pagy.from, to: pagy.to)
    end

  end
end
