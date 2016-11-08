# -*- encoding: utf-8 -*-
# frozen_string_literal: true

require 'spec_helper'

def version_cmd
  return 'dpkg-query -W ntp' if %w(debian ubuntu).include?(os[:family])
  return 'rpm -q --info ntp | grep Version' if %w(redhat).include?(os[:family])
end

RSpec.describe ENV['KITCHEN_INSTANCE'] || host_inventory['hostname'] do
  context 'NTP:INSTALL' do
    describe 'NTP package' do
      subject { package('ntp') }
      it { is_expected.to be_installed }
      if property['ntp_version']
        context 'version' do
          subject { command(version_cmd) }
          its(:stdout) { is_expected.to match(property['ntp_version']) }
        end
      end
    end
  end
end
