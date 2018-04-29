node.reverse_merge!(
  rbenv: {
    global: '2.3.1',
    versions: %w[
      2.3.1
      2.2.5
    ],
  }
)

result = run_command('type -p rbenv', error: false)
include_recipe 'rbenv::user' if result.exit_status != 0
