case node[:arch]
when 'x86_64' then
  arch = 'amd64'
when 'aarch64' then
  arch = 'arm64'
else
  raise "not supported arch: #{node[:arch]}"
end

github_binary 'peco' do
  repository 'peco/peco'
  version 'v0.5.3'
  ext = (node[:platform] == 'darwin' ? 'zip' : 'tar.gz')
  archive "peco_#{node[:os]}_#{arch}.#{ext}"
  binary_path "peco_#{node[:os]}_#{arch}/peco"
end
