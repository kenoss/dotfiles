define :dotfile, source: nil do
  source = params[:source] || params[:name]
  dest = File.join(node[:home], params[:name])
  dir = File.dirname(dest)
  directory dir do
    user node[:user]
    not_if "test -d #{dir}"
  end
  link dest do
    to File.expand_path("../../../config/#{source}", __FILE__)
    user node[:user]
    not_if "test -e #{dest}"
  end
end

define :github_binary, version: nil, repository: nil, archive: nil, binary_path: nil do
  cmd = params[:name]
  bin_path = "#{node[:home]}/.local/bin/#{cmd}"
  archive = params[:archive]
  url = "https://github.com/#{params[:repository]}/releases/download/#{params[:version]}/#{archive}"

  execute "mkdir -p #{node[:home]}/.local/bin" do
    not_if "test -d #{node[:home]}/.local/bin"
  end

  if archive.end_with?('.zip')
    extract = "unzip -o"
  elsif archive.end_with?('.tar.gz')
    extract = "tar xvzf"
  else
    extract = nil
  end

  if extract
    src = "/tmp/#{params[:binary_path] || cmd}"
  else
    src = "/tmp/#{archive}"
  end

  execute "curl -fSL -o /tmp/#{archive} #{url}" do
    not_if "test -f #{bin_path}"
  end

  if extract
    execute "#{extract} /tmp/#{archive}" do
      not_if "test -f #{bin_path}"
      cwd "/tmp"
    end
  end

  execute "install -m 755 -o #{node[:user]} -g #{node[:user]} #{src} #{bin_path}" do
    not_if "test -f #{bin_path}"
  end
end

define :user_service, action: [] do
  name = params[:name]

  Array(params[:action]).each do |action|
    case action
    when :enable
      execute "sudo -E -u #{node[:user]} systemctl --user enable #{name}" do
        not_if "sudo -E -u #{node[:user]} systemctl --user --quiet is-enabled #{name}"
      end
    when :start
      execute "sudo -E -u #{node[:user]} systemctl --user start #{name}" do
        not_if "sudo -E -u #{node[:user]} systemctl --user --quiet is-active #{name}"
      end
    end
  end
end
