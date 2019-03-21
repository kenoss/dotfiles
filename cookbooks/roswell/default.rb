default = 'sbcl/1.5.0'

result = run_command('type -p ros', error: false)
if result.exit_status != 0
  execute 'brew install roswell'
  execute 'ros setup'
  execute "ros install #{default}"
  execute "ros use #{default}"
  execute 'ros install slime'
end
