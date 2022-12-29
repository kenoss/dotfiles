include_recipe 'recipe_helper'

node.reverse_merge!(
  user: ENV['SUDO_USER'] || ENV['USER'],
)

node.reverse_merge!(
  arch: run_command('uname -m', error: false).stdout.strip,
)

include_role node[:platform]
