# encoding: utf-8
# frozen_string_literal: true

require_relative '../../test_helper'
require 'i18n'
require 'pagy/extras/i18n'

SimpleCov.command_name 'i18n' if ENV['RUN_SIMPLECOV']

describe Pagy::Frontend do

  let(:frontend) { TestView.new }

  describe "#pagy_t with I18n" do

    it 'pluralizes' do
      frontend.pagy_t('pagy.nav.prev').must_equal "&lsaquo;&nbsp;Prev"
      frontend.pagy_t('pagy.info.no_items', count: 0).must_equal "No items found"
      frontend.pagy_t('pagy.info.single_page', count: 1).must_equal  "Displaying <b>1</b> item"
      frontend.pagy_t('pagy.info.single_page', count: 10).must_equal "Displaying <b>all 10</b> items"
    end

    it 'handles missing paths' do
      frontend.pagy_t('pagy.nav.not_here').must_equal 'translation missing: en.pagy.nav.not_here'
    end

  end

  describe '#pagy_collection_info with I18n' do

    it 'renders info' do
      frontend.pagy_info(Pagy.new count: 0).must_equal "No items found"
      frontend.pagy_info(Pagy.new count: 1).must_equal "Displaying <b>1</b> item"
      frontend.pagy_info(Pagy.new count: 13).must_equal "Displaying <b>all 13</b> items"
      frontend.pagy_info(Pagy.new count: 100, page: 3).must_equal "Displaying items <b>41-60</b> of <b>100</b> in total"
    end

    it 'renders with existing i18n path' do
      ::I18n.locale = 'en'
      custom_dictionary = File.join(File.dirname(__FILE__), 'i18n.yml')
      ::I18n.load_path += [custom_dictionary]
      frontend.pagy_collection_info(Pagy.new count: 0, collection_path: 'activerecord.models.product').must_equal "No Products found"
      frontend.pagy_collection_info(Pagy.new count: 1, collection_path: 'activerecord.models.product').must_equal "Displaying <b>1</b> Product"
      frontend.pagy_collection_info(Pagy.new count: 13, collection_path: 'activerecord.models.product').must_equal "Displaying <b>all 13</b> Products"
      frontend.pagy_collection_info(Pagy.new count: 100, collection_path: 'activerecord.models.product', page: 3).must_equal "Displaying Products <b>41-60</b> of <b>100</b> in total"
    end
  end

end
