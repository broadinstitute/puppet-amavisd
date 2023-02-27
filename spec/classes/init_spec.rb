require 'spec_helper'

describe 'amavisd' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it do
        is_expected.to compile.with_all_deps
      end

      context 'with defaults for all parameters' do
        it do
          is_expected.to contain_class('amavisd')
        end
        it do
          is_expected.to contain_group('amavis').with_ensure('present')
        end
        it do
          is_expected.to contain_user('amavis').with_ensure('present')
        end
        it do
          is_expected.to contain_service('amavisd_service').with_enable(true)
        end
        it do
          is_expected.to contain_service('amavisd_service').with_ensure('running')
        end
        it do
          is_expected.to contain_package('amavisd-new').with_ensure('present')
        end
      end

      context 'with manage_group => false' do
        let(:params) do
          { manage_group: false }
        end

        it do
          is_expected.not_to contain_group('amavis')
        end
      end

      context 'with manage_user => false' do
        let(:params) do
          { manage_user: false }
        end

        it do
          is_expected.not_to contain_user('amavis')
        end
      end

      context 'with custom group' do
        let(:params) do
          { daemon_group: 'testgrp' }
        end

        it do
          is_expected.to contain_group('testgrp').with_ensure('present')
        end
      end

      context 'with custom user' do
        let(:params) do
          { daemon_user: 'testuser' }
        end

        it do
          is_expected.to contain_user('testuser').with_ensure('present')
        end
      end

      context 'with package_ensure => absent' do
        let(:params) do
          { package_ensure: 'absent' }
        end

        it do
          is_expected.to contain_package('amavisd-new').with_ensure('absent')
        end
      end

      context 'with service_enable => false' do
        let(:params) do
          { service_enable: false }
        end

        it do
          is_expected.to contain_service('amavisd_service').with_enable(false)
        end
      end

      context 'with service_ensure => stopped' do
        let(:params) do
          { service_ensure: 'stopped' }
        end

        it do
          is_expected.to contain_service('amavisd_service').with_ensure('stopped')
        end
      end

      context 'with custom service_name' do
        let(:params) do
          { service_name: 'amavistest' }
        end

        it do
          is_expected.to contain_service('amavisd_service').with_name('amavistest')
        end
      end

      case facts[:osfamily]
      when 'Debian', 'Ubuntu'
        context 'osfamily differences with defaults for all parameters' do
          it do
            is_expected.to contain_class('apt')
          end
          it do
            is_expected.not_to contain_class('epel')
          end
          it do
            is_expected.to contain_concat('/etc/amavis/conf.d/60-puppet')
          end
          it do
            is_expected.to contain_service('amavisd_service').with_name('amavis')
          end
        end

        context 'with a custom config_dir' do
          let(:params) do
            { config_dir: '/etc/testing' }
          end

          it do
            is_expected.to contain_concat('/etc/testing/60-puppet')
          end
        end

        context 'with a custom config_file' do
          let(:params) do
            { config_file: 'test.conf' }
          end

          it do
            is_expected.to contain_concat('/etc/amavis/conf.d/test.conf')
          end
        end

      when 'RedHat'
        context 'osfamily differences with defaults for all parameters' do
          it do
            is_expected.to contain_class('epel')
          end
          it do
            is_expected.not_to contain_class('apt')
          end
          it do
            is_expected.to contain_concat('/etc/amavisd/amavisd.conf')
          end
          it do
            is_expected.to contain_service('amavisd_service').with_name('amavisd')
          end
        end

        context 'with manage_epel => false' do
          let(:params) do
            { manage_epel: false }
          end

          it do
            is_expected.not_to contain_class('epel')
          end
        end

        context 'with a custom config_dir' do
          let(:params) do
            { config_dir: '/etc/testing' }
          end

          it do
            is_expected.to contain_concat('/etc/testing/amavisd.conf')
          end
        end

        context 'with a custom config_file' do
          let(:params) do
            { config_file: 'test.conf' }
          end

          it do
            is_expected.to contain_concat('/etc/amavisd/test.conf')
          end
        end
      end
    end
  end

  context 'specific to Amazon Linux' do
    let(:facts) do
      {
        os: {
          family: 'RedHat',
          name: 'Amazon',
          release: {
            full: '7.2',
            major: '7',
          }
        }
      }
    end

    context 'It should not include epel' do
      it do
        is_expected.not_to contain_class('epel')
      end
    end
  end

  context 'specific to Fedora' do
    let(:facts) do
      {
        os: {
          family: 'RedHat',
          name: 'Fedora',
          release: {
            full: '7.2',
            major: '7',
          }
        }
      }
    end

    context 'It should not include epel' do
      it do
        is_expected.not_to contain_class('epel')
      end
    end
  end
end

# it {
#   should contain_concat__fragment('').with(
#     :content => // )
# }
