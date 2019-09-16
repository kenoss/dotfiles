case node[:platform]
when 'darwin'
  execute "cp -a ./cookbooks/font-ricty/files/repo/powerline-fontpatched/*.ttf #{ENV['HOME']}/Library/Fonts" do
    not_if "test -f '#{ENV['HOME']}/Library/Fonts/Ricty Diminished Discord Regular for Powerline.ttf'"
  end
else
  raise 'not supported platform'
end
