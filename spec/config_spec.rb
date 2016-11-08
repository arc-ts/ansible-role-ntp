# -*- encoding: utf-8 -*-
# frozen_string_literal: true

require 'spec_helper'
require 'support/helpers'

def element_str(element)
  return element[0].to_s if element[1].nil?
  "#{element[0]} #{element[1]}"
end

RSpec.describe ENV['KITCHEN_INSTANCE'] || host_inventory['hostname'] do
  property.store('ntp_config_keys', keys_file) if property['ntp_manage_keys']
  property.store('ntp_config_leapfile', property['ntp_leapfile_file']) if
    property['ntp_manage_leapfile']
  property.store('ntp_config_driftfile', drift_file) unless property.key?('ntp_config_driftfile')
  context 'NTP:CONFIG' do
    if property['ntp_config_statsdir']
      describe 'NTP statsdir' do
        subject { file(property['ntp_config_statsdir']) }
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'ntp' }
        it { is_expected.to be_grouped_into 'ntp' }
        it { is_expected.to be_mode 755 }
      end
    end
    describe 'NTP Config file' do
      subject { file('/etc/ntp.conf') }
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_mode 644 }
      if property['ntp_config_discard']
        property['ntp_config_discard'].each do |element|
          its(:content) { is_expected.to match(/^discard.*#{element_str(element)}/) }
        end
      end
      if property['ntp_config_restrict']
        property['ntp_config_restrict'].each do |key, value|
          if value.nil?
            its(:content) { is_expected.to match(/^restrict #{key}$/) }
          else
            value.each do |element|
              its(:content) { is_expected.to match(/^restrict #{key}.*#{element_str(element)}/) }
            end
          end
        end
      end
      if property['ntp_config_automax']
        its(:content) { is_expected.to match(/^automax #{property['ntp_config_automax']}$/) }
      end
      if property['ntp_config_controlkey']
        its(:content) { is_expected.to match(/^controlkey #{property['ntp_config_controlkey']}$/) }
      end
      if property['ntp_config_crypto']
        property['ntp_config_crypto'].each do |element|
          its(:content) { is_expected.to match(/^crypto.*#{element_str(element)}/) }
        end
      end
      if property['ntp_config_keys']
        its(:content) { is_expected.to match(/^keys #{property['ntp_config_keys']}$/) }
      end
      if property['ntp_config_keysdir']
        its(:content) { is_expected.to match(/^keysdir #{property['ntp_config_keysdir']}$/) }
      end
      if property['ntp_config_requestkey']
        its(:content) { is_expected.to match(/^keysdir #{property['ntp_config_requestkey']}$/) }
      end
      if property['ntp_config_revoke']
        its(:content) { is_expected.to match(/^revoke #{property['ntp_config_revoke']}$/) }
      end
      if property['ntp_config_trustedkey']
        property['ntp_config_trustedkey'].each do |element|
          its(:content) { is_expected.to match(/^trustedkey.*#{element_str(element)}/) }
        end
      end
      if property['ntp_config_filegen']
        property['ntp_config_filegen'].each do |key, value|
          value.each do |element|
            its(:content) { is_expected.to match(/^filegen #{key}.*#{element_str(element)}/) }
          end
        end
      end
      if property['ntp_config_statsdir']
        its(:content) { is_expected.to match(/^statsdir #{property['ntp_config_statsdir']}$/) }
      end
      if property['ntp_config_broadcast']
        property['ntp_config_broadcast'].each do |key, value|
          if value.nil?
            its(:content) { is_expected.to match(/^broadcast #{key}$/) }
          else
            value.each do |element|
              its(:content) { is_expected.to match(/^broadcast #{key}.*#{element_str(element)}/) }
            end
          end
        end
      end
      if property['ntp_config_broadcastclient']
        its(:content) do
          is_expected.to match(/^broadcastclient #{property['ntp_config_broadcastclient']}$/)
        end
      end
      if property['ntp_config_manycastclient']
        property['ntp_config_manycastclient'].each do |key, value|
          if value.nil?
            its(:content) { is_expected.to match(/^manycastclient #{key}$/) }
          else
            value.each do |element|
              its(:content) do
                is_expected.to match(/^manycastclient #{key}.*#{element_str(element)}/)
              end
            end
          end
        end
      end
      if property['ntp_config_manycastserver']
        property['ntp_config_manycastserver'].each do |key, value|
          if value.nil?
            its(:content) { is_expected.to match(/^manycastserver #{key}$/) }
          else
            value.each do |element|
              its(:content) do
                is_expected.to match(/^manycastserver #{key}.*#{element_str(element)}/)
              end
            end
          end
        end
      end
      if property['ntp_config_multicastclient']
        property['ntp_config_multicastclient'].each do |key, value|
          if value.nil?
            its(:content) { is_expected.to match(/^multicastclient #{key}$/) }
          else
            value.each do |element|
              its(:content) do
                is_expected.to match(/^multicastclient #{key}.*#{element_str(element)}/)
              end
            end
          end
        end
      end
      if property['ntp_config_peer']
        property['ntp_config_peer'].each do |key, value|
          if value.nil?
            its(:content) { is_expected.to match(/^peer #{key}$/) }
          else
            value.each do |element|
              its(:content) { is_expected.to match(/^peer #{key}.*#{element_str(element)}/) }
            end
          end
        end
      end
      if property['ntp_config_pool']
        property['ntp_config_pool'].each do |key, value|
          if value.nil?
            its(:content) { is_expected.to match(/^pool #{key}$/) }
          else
            value.each do |element|
              its(:content) { is_expected.to match(/^pool #{key}.*#{element_str(element)}/) }
            end
          end
        end
      end
      if property['ntp_config_server']
        property['ntp_config_server'].each do |key, value|
          if value.nil?
            its(:content) { is_expected.to match(/^server #{key}$/) }
          else
            value.each do |element|
              its(:content) { is_expected.to match(/^server #{key}.*#{element_str(element)}/) }
            end
          end
        end
      end
      if property['ntp_config_server']
        property['ntp_config_server'].each do |key, value|
          if value.nil?
            its(:content) { is_expected.to match(/^server #{key}$/) }
          else
            value.each do |element|
              its(:content) { is_expected.to match(/^server #{key}.*#{element_str(element)}/) }
            end
          end
        end
      end
      if property['ntp_config_fudge']
        property['ntp_config_fudge'].each do |key, value|
          if value.nil?
            its(:content) { is_expected.to match(/^fudge #{key}$/) }
          else
            value.each do |element|
              its(:content) { is_expected.to match(/^fudge #{key}.*#{element_str(element)}/) }
            end
          end
        end
      end
      if property['ntp_config_broadcastdelay']
        its(:content) do
          is_expected.to match(/^broadcastdelay #{property['ntp_config_broadcastdelay']}$/)
        end
      end
      if property['ntp_config_driftfile']
        its(:content) { is_expected.to match(/^driftfile #{property['ntp_config_driftfile']}$/) }
      end
      if property['ntp_config_enable']
        property['ntp_config_enable'].each do |element|
          its(:content) { is_expected.to match(/^enable.*#{element_str(element)}/) }
        end
      end
      if property['ntp_config_disable']
        property['ntp_config_disable'].each do |element|
          its(:content) { is_expected.to match(/^disable.*#{element_str(element)}/) }
        end
      end
      if property['ntp_config_interface']
        property['ntp_config_interface'].each do |key, value|
          if value.nil?
            its(:content) { is_expected.to match(/^inferface #{key}$/) }
          else
            value.each do |element|
              its(:content) { is_expected.to match(/^interface #{key}.*#{element_str(element)}/) }
            end
          end
        end
      end
      if property['ntp_config_leapfile']
        its(:content) { is_expected.to match(/^leapfile #{property['ntp_config_leapfile']}$/) }
      end
      if property['ntp_config_logconfig']
        its(:content) { is_expected.to match(/^logconfig #{property['ntp_config_logconfig']}$/) }
      end
      if property['ntp_config_logfile']
        its(:content) { is_expected.to match(/^logfile #{property['ntp_config_logfile']}$/) }
      end
      if property['ntp_config_tinker']
        property['ntp_config_tinker'].each do |element|
          its(:content) { is_expected.to match(/^tinker.*#{element_str(element)}/) }
        end
      end
      if property['ntp_config_tos']
        property['ntp_config_tos'].each do |element|
          its(:content) { is_expected.to match(/^tos.*#{element_str(element)}/) }
        end
      end
      if property['ntp_config_trap']
        property['ntp_config_trap'].each do |element|
          its(:content) { is_expected.to match(/^trap.*#{element_str(element)}/) }
        end
      end
      if property['ntp_config_ttl']
        property['ntp_config_ttl'].each do |element|
          its(:content) { is_expected.to match(/^ttl.*#{element_str(element)}/) }
        end
      end
    end
    describe 'NTP Service' do
      subject { service(ntp_service_name) }
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
