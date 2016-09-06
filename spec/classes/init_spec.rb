require 'spec_helper'

describe 'amavisd' do

  # on_supported_os.each do |os, facts|
  #   context "on #{os}" do
  #     let(:facts) do
  #       facts
  #     end

  [ 'Debian', 'RedHat' ].each do |osfamily|

    context "on #{osfamily}" do

      if osfamily == 'Debian'
        let(:facts) { {
          :osfamily               => 'Debian',
          :operatingsystem        => 'Debian',
          :lsbdistid              => 'Debian',
          :lsbdistcodename        => 'wheezy',
          :kernelrelease          => '3.2.0-4-amd64',
          :operatingsystemrelease => '7.3',
          :operatingsystemmajrelease => '7',
        } }

        context 'with defaults for all parameters' do
          it { should contain_class('amavisd') }
          it { should contain_class('apt') }
          it { should contain_group('amavis').with_ensure('present') }
          it { should contain_user('amavis').with_ensure('present') }
          it { should contain_package('amavisd-new').with_ensure('present') }
          it { should contain_service('amavis').with_enable(true) }
          it { should contain_service('amavis').with_ensure('running') }
          it { should contain_concat('/etc/amavis/conf.d/60-puppet') }
        end

        context 'with a custom config_dir' do
          let (:params) { { :config_dir => '/etc/testing' } }

          it { should contain_concat('/etc/testing/60-puppet') }
        end

        context 'with a custom config_file' do
          let (:params) { { :config_file => 'test.conf' } }

          it { should contain_concat('/etc/amavis/conf.d/test.conf') }
        end

      end

      if osfamily == 'RedHat'
        let(:facts) { {
          :osfamily => osfamily,
          :operatingsystem => 'RedHat',
          :operatingsystemrelease => '7.2',
          :operatingsystemmajrelease => '7',
        } }

        context 'with defaults for all parameters' do
          it { should contain_class('amavisd') }
          it { should contain_class('epel') }
          it { should contain_group('amavis').with_ensure('present') }
          it { should contain_user('amavis').with_ensure('present') }
          it { should contain_package('amavisd-new').with_ensure('present') }
          it { should contain_service('amavisd').with_enable(true) }
          it { should contain_service('amavisd').with_ensure('running') }
          it { should contain_concat('/etc/amavisd/amavisd.conf') }
        end

        context 'It should not include epel if manage_epel => false' do
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