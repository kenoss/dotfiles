case node[:platform]
when 'arch'
  package 'rust'
  package 'cargo'

  include_cookbook 'yaourt'
  yaourt 'rust-src'
else
  local_ruby_block 'install rust' do
    rustc_path = "#{ENV['USER_HOME']}/.cargo/bin/rustc"

    block do
      system("sudo -E -u #{node[:user]} bash -c 'curl https://sh.rustup.rs -sSf | sh'")

      until File.exist?(rustc_path)
        sleep 1
      end
    end
    not_if "test -f #{rustc_path}"
  end
end

unless ENV['PATH'].include?("#{ENV['USER_HOME']}/.cargo/bin:")
  MItamae.logger.info('Prepending ~/.cargo/bin to PATH during this execution')
  ENV['PATH'] = "#{ENV['USER_HOME']}/.cargo/bin:#{ENV['PATH']}"
end

execute 'rustup component add rust-src' do
  not_if 'rustup component list | grep "rust-src (installed)" >/dev/null'
end

define :cargo do
  execute "cargo install --verbose #{params[:name]}" do
    not_if %Q[cargo install --list | grep "^#{params[:name]} "]
  end
end
