namespace :api do
  desc "API Routes"
  task :routes => :environment do
    Api::Base.routes.each do |api|
      next unless api.route_method
      method = api.route_method.ljust(10)
      path = api.route_path.gsub(":version", api.route_version)
      puts "     #{method} #{path}"
    end
  end
end
