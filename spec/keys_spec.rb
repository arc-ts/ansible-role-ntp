# -*- encoding: utf-8 -*-
# frozen_string_literal: true

require 'spec_helper'
require 'support/helpers'

if property['ntp_manage_keys']
  RSpec.describe ENV['KITCHEN_INSTANCE'] || host_inventory['hostname'] do
    context 'NTP:KEYS' do
      describe 'keys file' do
        subject { file(keys_file) }
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by property['ntp_keys_file_owner'] }
        it { is_expected.to be_grouped_into property['ntp_keys_file_group'] }
        it { is_expected.to be_mode property['ntp_keys_file_mode'].to_i }
        property['ntp_keys_ids'].each do |id, config|
          key_entry = Regexp.new(/^#{id}\s#{config['type']}\s#{config['key']}$/)
          its(:content) { is_expected.to match(key_entry) }
        end
      end
    end
  end
end
