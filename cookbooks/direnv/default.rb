github_binary 'direnv' do
  repository 'direnv/direnv'
  version 'v2.21.2'
  archive "direnv.#{node[:os]}-amd64"
end
