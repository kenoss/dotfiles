node.reverse_merge!(
  rbenv: {
    global: '2.5.0',
    versions: %w[
      2.5.0
    ],
  }
)

result = run_command('type -p rbenv', error: false)
include_recipe 'rbenv::user' if result.exit_status != 0
