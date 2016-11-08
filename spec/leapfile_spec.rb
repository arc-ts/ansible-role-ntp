# -*- encoding: utf-8 -*-
# frozen_string_literal: true

require 'spec_helper'

if property['ntp_manage_leapfile']
  RSpec.describe ENV['KITCHEN_INSTANCE'] || host_inventory['hostname'] do
    context 'NTP:LEAPFILE' do
      describe 'NTP leapfile' do
        subject { file(property['ntp_leapfile_file']) }
        it { is_expected.to be_file }
        it { is_expected.to be_owned_by property['ntp_leapfile_file_owner'] }
        it { is_expected.to be_grouped_into property['ntp_leapfile_file_group'] }
        it { is_expected.to be_mode property['ntp_leapfile_file_mode'].to_i }
      end
    end
  end
end
