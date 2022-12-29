case node[:arch]
when 'x86_64' then
  arch = 'amd64'
when 'aarch64' then
  arch = 'arm64'
else
  raise "not supported arch: #{node[:arch]}"
end

github_binary 'ghq' do
  repository 'motemen/ghq'
  version 'v1.3.0'
  archive "ghq_#{node[:os]}_#{arch}.zip"
end

include_cookbook 'git'
