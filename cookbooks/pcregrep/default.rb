case node[:platform]
when 'debian' then
  package 'pcregrep'
when 'fedora' then
  package 'pcre-tools'
else
  package 'pcre'
end
