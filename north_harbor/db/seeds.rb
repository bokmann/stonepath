User.create(:username=> "darryl",
            :role => "data_entry_clerk",
            :email => "darryl@demo.com",
            :password => "password",
            :password_confirmation => "password")
     
User.create(:username=> "patty",
            :role => "data_entry_clerk",
            :email => "patty@demo.com",
            :password => "password",
            :password_confirmation => "password")
            
User.create(:username=> "selma",
            :role => "data_entry_clerk",
            :email => "selma@demo.com",
            :password => "password",
            :password_confirmation => "password")      
             
User.create(:username=> "mike",
            :role => "customer_satisfaction_manager",
            :email => "mike@demo.com",
            :password => "password",
            :password_confirmation => "password")   

User.create(:username=> "nicole",
            :role => "customer_satisfaction_manager",
            :email => "nicole@demo.com",
            :password => "password",
            :password_confirmation => "password")
                            
User.create(:username=> "ron",
            :role => "store_manager",
            :email => "ron@demo.com",
            :password => "password",
            :password_confirmation => "password")   
  
User.create(:username=> "sue",
            :role => "store_manager",
            :email => "sue@demo.com",
            :password => "password",
            :password_confirmation => "password")
           
User.create(:username=> "andy",
            :role => "administrator",
            :email => "andy@demo.com",
            :password => "password",
            :password_confirmation => "password")
            
User.create(:username=> "natasha",
            :role => "customer_satisfaction_specialist",
            :email => "natasha@demo.com",
            :password => "password",
            :password_confirmation => "password")
            
User.create(:username=> "crystal",
            :role => "customer_satisfaction_specialist",
            :email => "crystal@demo.com",
            :password => "password",
            :password_confirmation => "password")
            
User.create(:username=> "kim",
            :role => "customer_satisfaction_specialist",
            :email => "kim@demo.com",
            :password => "password",
            :password_confirmation => "password")
                                    
User.create(:username=> "denny",
            :role => "corporate_attorney",
            :email => "denny@demo.com",
            :password => "password",
            :password_confirmation => "password")
            
User.create(:username=> "alan",
            :role => "corporate_attorney",
            :email => "alan@demo.com",
            :password => "password",
            :password_confirmation => "password")
            
Store.create(:location => "1341 Old Colonial Highway, Suite 400",
             :manager => User.find_by_username("ron"))
             
 Store.create(:location => "13416 Captain Harkness Drive",
              :manager => User.find_by_username("sue"))             
                                                  