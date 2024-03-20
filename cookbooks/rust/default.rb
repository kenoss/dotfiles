define :install_rust do
  rustc_path = "#{node[:home]}/.cargo/bin/rustc"

  execute 'curl -sSf https://sh.rustup.rs -o /tmp/rustup-init.sh' do
    not_if "test -f #{rustc_path}"
  end

  local_ruby_block 'install rust' do

    block do

      system("sudo -E -u #{node[:user]} bash /tmp/rustup-init.sh --default-toolchain stable --profile default --component rustfmt -y")

      until File.exist?(rustc_path)
        sleep 1
      end
    end

    not_if "test -f #{rustc_path}"
  end
end

install_rust ""

unless ENV['PATH'].include?("#{node[:home]}/.cargo/bin:")
  MItamae.logger.info('Prepending ~/.cargo/bin to PATH during this execution')
  ENV['PATH'] = "#{node[:home]}/.cargo/bin:#{ENV['PATH']}"
end

rustup = "#{node[:home]}/.cargo/bin/rustup"
cargo = "#{node[:home]}/.cargo/bin/cargo"

execute "sudo -E -u #{node[:user]} #{rustup} component add rust-src" do
  not_if "sudo -E -u #{node[:user]} #{rustup} component list | grep 'rust-src (installed)' >/dev/null"
end

define :cargo do
  execute "sudo -E -u #{node[:user]} #{cargo} install --verbose #{params[:name]}" do
    not_if %Q[sudo -E -u #{node[:user]} #{cargo} install --list | grep "^#{params[:name]} "]
  end
end
