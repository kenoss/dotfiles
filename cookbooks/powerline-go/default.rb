github_binary 'powerline-go' do
  repository 'justjanne/powerline-go'
  version 'v1.13.0'
  archive "powerline-go-#{node[:os]}-amd64"
  binary_path "powerline-go-#{node[:os]}-amd64"
end
