include_recipe 'recipe_helper'

node.reverse_merge!(
  user: ENV['SUDO_USER'] || ENV['USER'],
)

# In some Linux distribution, `sudo -E` doesn't preserve environment variables.
# Alternatively, we use `node[:home]`.
node.reverse_merge!(
  home: run_command("sudo -u #{node[:user]} printenv HOME", error: false).stdout.strip,
)

node.reverse_merge!(
  arch: run_command('uname -m', error: false).stdout.strip,
)

include_role node[:platform]
