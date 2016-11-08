# -*- encoding: utf-8 -*-
# frozen_string_literal: true

require 'spec_helper'

def keys_file
  return property['ntp_keysfile_file'] if property['ntp_keysfile_file']
  return '/etc/ntp.keys' if %w(debian ubuntu).include?(os[:family])
  return '/etc/ntp/keys' if %w(redhat).include?(os[:family])
end

def drift_file
  return '/var/lib/ntp/ntp.drift' if %w(debian ubuntu).include?(os[:family])
  return '/var/lib/ntp/drift' if %w(redhat).include?(os[:family])
end

def ntp_service_name
  return 'ntp' if %w(debian ubuntu).include?(os[:family])
  return 'ntpd' if %w(redhat).include?(os[:family])
end
