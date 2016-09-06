require 'spec_helper'

describe 'amavisd' do

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { should compile.with_all_deps }

      context 'with defaults for all parameters' do
        it { should contain_class('amavisd') }
        it { should contain_group('amavis').with_ensure('present') }
        it { should contain_user('amavis').with_ensure('present') }
        it { should contain_service('amavisd_service').with_enable(true) }
        it { should contain_service('amavisd_service').with_ensure('running') }
        it { should contain_package('amavisd-new').with_ensure('present') }
      end

      context 'with manage_group => false' do
        let (:params) { { :manage_group => false } }

        it { should_not contain_group('amavis') }
      end

      context 'with manage_user => false' do
        let (:params) { { :manage_user => false } }

        it { should_not contain_user('amavis') }
      end

      context 'with custom group' do
        let (:params) { { :daemon_group => 'testgrp' } }

        it { should contain_group('testgrp').with_ensure('present') }
      end

      context 'with custom user' do
        let (:params) { { :daemon_user => 'testuser' } }

        it { should contain_user('testuser').with_ensure('present') }
      end

      context 'with package_ensure => absent' do
        let (:params) { { :package_ensure => 'absent' } }

        it { should contain_package('amavisd-new').with_ensure('absent') }
      end

      context 'with service_enable => false' do
        let (:params) { { :service_enable => false } }

        it { should contain_service('amavisd_service').with_enable(false) }
      end

      context 'with service_ensure => stopped' do
        let (:params) { { :service_ensure => 'stopped' } }

        it { should contain_service('amavisd_service').with_ensure('stopped') }
      end

      context 'with custom service_name' do
        let (:params) { { :service_name => 'amavistest' } }

        it { should contain_service('amavisd_service').with_name('amavistest') }
      end

      case facts[:osfamily]
      when 'Debian'

        context 'osfamily differences with defaults for all parameters' do
          it { should contain_class('apt') }
          it { should_not contain_class('epel') }
          it { should contain_concat('/etc/amavis/conf.d/60-puppet') }
          it { should contain_service('amavisd_service').with_name('amavis') }
        end

        context 'with a custom config_dir' do
          let (:params) { { :config_dir => '/etc/testing' } }

          it { should contain_concat('/etc/testing/60-puppet') }
        end

        context 'with a custom config_file' do
          let (:params) { { :config_file => 'test.conf' } }

          it { should contain_concat('/etc/amavis/conf.d/test.conf') }
        end

      when 'RedHat'

        context 'osfamily differences with defaults for all parameters' do
          it { should contain_class('epel') }
          it { should_not contain_class('apt') }
          it { should contain_concat('/etc/amavisd/amavisd.conf') }
          it { should contain_service('amavisd_service').with_name('amavisd') }
        end

        context 'with manage_epel => false' do
          let (:params) { { 'manage_epel' => false } }

          it { should_not contain_class('epel') }
        end

        context 'with a custom config_dir' do
          let (:params) { { :config_dir => '/etc/testing' } }

          it { should contain_concat('/etc/testing/amavisd.conf') }
        end

        context 'with a custom config_file' do
          let (:params) { { :config_file => 'test.conf' } }

          it { should contain_concat('/etc/amavisd/test.conf') }
        end

      end

    end

  end

  context "specific to Amazon Linux" do

    let(:facts) { {
      :osfamily => 'RedHat',
      :operatingsystem => 'Amazon',
      :operatingsystemrelease => '7.2',
      :operatingsystemmajrelease => '7',
    } }

    context 'It should not include epel' do
      it { should_not contain_class('epel') }
    end
  end

  context "specific to Fedora" do

    let(:facts) { {
      :osfamily => 'RedHat',
      :operatingsystem => 'Fedora',
      :operatingsystemrelease => '7.2',
      :operatingsystemmajrelease => '7',
    } }

    context 'It should not include epel' do
      it { should_not contain_class('epel') }
    end
  end

end

# it {
#   should contain_concat__fragment('').with(
#     :content => // )
# }