node[:deploy].each do |application, deploy|
  
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
