node[:deploy].each do |application, deploy|
  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    curl -s https://getcomposer.org/installer | php
    php composer.phar install
    EOH
  end  
  template "#{deploy[:deploy_to]}/current/.htaccess" do
    source "htaccess.erb"
    owner deploy[:user] 
    group deploy[:group]
    mode "0660"

    variables( :env => node[:custom_env], :application => "#{application}" )

    only_if do
     File.directory?("#{deploy[:deploy_to]}/current/")
    end
  end
end
