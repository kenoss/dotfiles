case node[:os]
when 'darwin' then
  fonts_dir = "#{node[:home]}/Library/Fonts"
when 'linux' then
  fonts_dir = "#{node[:home]}/.fonts"
else
  raise "not supported os: #{node[:os]}"
end

directory fonts_dir do
  user node[:user]
end


define :ricty_font, file: nil do
  repo = 'https://github.com/mzyy94/RictyDiminished-for-Powerline'
  file = "#{params[:name]}"
  url = "#{repo}/raw/master/powerline-fontpatched/#{file.gsub(/ /, '%20')}"

  dest = "#{fonts_dir}/#{file}"

  execute "curl -fSL #{url} -o '#{dest}'" do
    not_if "test -f '#{dest}'"
    user node[:user]
  end
end


ls_output_before = run_command("ls -1 #{fonts_dir}/Ricty* | wc -l", error: false).stdout

ricty_font 'Ricty Diminished Bold Oblique for Powerline.ttf'
ricty_font 'Ricty Diminished Bold for Powerline.ttf'
ricty_font 'Ricty Diminished Bold Oblique for Powerline.ttf'
ricty_font 'Ricty Diminished Discord Bold for Powerline.ttf'
ricty_font 'Ricty Diminished Discord Bold Oblique for Powerline.ttf'
ricty_font 'Ricty Diminished Discord Oblique for Powerline.ttf'
ricty_font 'Ricty Diminished Discord Regular for Powerline.ttf'
ricty_font 'Ricty Diminished Oblique for Powerline.ttf'
ricty_font 'Ricty Diminished Regular for Powerline.ttf'

ls_output_after =  run_command("ls -1 #{fonts_dir}/Ricty* | wc -l", error: false).stdout


case node[:os]
when 'darwin'
when 'linux' then
  execute 'fc-cache -fv' do
    not_if ls_output_before == ls_output_after
    user node[:user]
  end
else
  raise "not supported os: #{node[:os]}"
end
