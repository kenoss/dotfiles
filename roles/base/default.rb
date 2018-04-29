bin_dir = File.join(ENV['HOME'], 'bin')
directory bin_dir do
  owner node[:user]
  not_if "test -e #{bin_dir}"
end

include_cookbook 'functions'
