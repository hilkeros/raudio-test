# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
#  RUNS IN SCHEDULER IN mooris-ch APP
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# EVERY DAY UTC 23:30
desc "Daily Clean up"
task :daily_clean_up => :environment do
  OrderJob.sale_done_clean_up
  OrderJob.store_invisible_clean_up
  OrderJob.clean_up_gift_items(30)
end

# HOURLY 10 AFTER
desc "Set Post Visible"
task :hourly_check_post_visibility => :environment do
  Post.hidden.each do |p|
    if p.should_be_visible
      p.update_attribute(:visible, true) 
    end
  end
end

# HOURLY :00
desc "reset_cache" 
task :reset_cache => :environment  do
  CacheJob.reset_cache
end


# EVERY DAY
desc "Daily Mail"
task :daily_mail => :environment do
  NewsletterJob.send_daily_newsletter
end

# EVERY DAY but if in code for only WEDNESDAYS
desc "Weekly Mail"
task :weekly_mail => :environment do
  NewsletterJob.send_weekly_newsletter
end

# EVERY 10 MINUTES
desc "Expire Clean Up"
  task :expire_clean_up => :environment do
  OrderJob.expire_clean_up
end



# HOURLY :00
desc "Clean Cache" 
task :cache_control => :environment  do
  CacheJob.reload_permanent_stores
end

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
#  RUNS IN SCHEDULER IN mooris-api APP
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# EVERY DAY UTC 19:00 on API
desc "Update Images for iPhone Thumb" 
task :reload_iphone_thumb => :environment  do
  PicJob.reload_iphone_thumb
end

# EVERY DAY UTC 20:00 on API
desc "Reload All API Cache" 
task :reload_api_cache => :environment do
  #Article.reindex
  Product.overview_and_6_hours.each{|p| p.notify_all_product_cache }
  Article.shown.each{|a| a.indexed_product.try(:notify_all_product_cache) }
  CacheJob.reload_api_cache
end

# EVERY DAY UTC 20:00 on API
desc "Preload API Store Cach" 
task :reload_api_store_cache => :environment do
    stores = Store.active.front_page + 
              Store.active.where(id: Theme.active.where("store_id IS NOT NULL").pluck(:store_id) ) +
              Store.active.where(id: Label.active.where("store_id is NOT NULL").pluck(:store_id) )

    stores.each do | store |
      url = URI.parse("http://api.mooris.com/api/v4/products.json?auth_token=xayNDpwBAqypGTBXkMuh&store_id=#{store.id}")
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
    end
end

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
#  RUNS IN SCHEDULER IN mooris-earl APP
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# EVERY DAY UTC 02:00
desc "Statistics"
task :statistic => :environment do
  Statistic.delete_all
  d1 = Date.new(2012, 6, 1)
  d2 = Date.today + 1.day
  days = (d2 - d1).to_i
  days.times do |d|
    day = d1 + d
    reve = Order.revenue_at day
    studio = Order.department_revenue_at(2, day)
    iphu = User.iphone_at day
    webu = User.web_user_at day
    new_buyer, old_buyer = 0, 0
    Order.includes(:user).payed.at(day).each do | o |
      if o.user && o.user.orders.payed.count > 1
        old_buyer += 1
      else
        new_buyer += 1
      end
    end
    s = Statistic.create day: d, earnings: reve || 0, studio_earnings: studio || 0,
                         iphone: iphu || 0, webmember: webu || 0,
                         old_buyer: old_buyer || 0, new_buyer: new_buyer || 0
  end
  AdminMailer.kpi.deliver_now
  AdminMailer.top.deliver_now
end

# EVERY DAY 12:30 UTC
desc "prepare Google CSV"
task :prepare_google_csv => :environment do
  GoogleRow.delay.prepare_google_csv
end

# EVERY DAY 20:00 UTC
desc "calculate_stats_for_current_products"
task :calculate_current_product_stats => :environment do
  ProductStatsJob.delay.stats_for_current_products
end

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
#  NOT RUN
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# NOT RUN
desc "Correcting limited? flag on product"
task :correkt_limited_caching => :environment do
  Product.active(DateTime.now).map{|p| p if !p.how_many_left.nil? ^ p.limited? }.compact.each do |p| p.set_limited! end
end

# NOT RUN
desc "Daily Buy Now"
task :daily_buy_now => :environment do
  OrderJob.remind_people
end

# NOT RUN
desc "Restart API"
task :restart_api => :environment do
  require 'heroku-api'
  heroku = Heroku::API.new
  heroku.post_ps_restart('mooris-api') 
end

# TODO FIX THIS
# NOT RUN
desc "Clean Up Intercom"
task :clean_up_intercom  => :environment do
  Intercom.app_id = IntercomRails.config.app_id 
  Intercom.api_key =  IntercomRails.config.api_key
  User.all.each do | u |
    user = Intercom::User.find_by_user_id( u.id )
    user.custom_data[:found_in_db]         = Time.now
    user.custom_data[:auth_code]           = u.authentication_token
    user.custom_data[:weekly_newsletter]   = u.weekly_newsletter   
    user.custom_data[:daily_newsletter]    = u.daily_newsletter    
    user.custom_data[:phone]               = u.phone 
    user.custom_data[:last_buy_at]         = u.orders.maximum(:created_at)
    user.custom_data[:total_orders_amount] = u.orders.map(&:total).sum       
  end 
end

# NOT RUN
desc "Minutes Clean up"
task :how_many_left_clean => :environment do
  OrderJob.clean_up_how_many_left(30)
  OrderJob.clean_up_gift_items(30)
end
