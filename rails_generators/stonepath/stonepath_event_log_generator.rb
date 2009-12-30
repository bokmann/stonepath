class StonepathEventLogGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      task_name = args[0]
       m.template('event_record.rb', "app/models/event_record.rb")
       m.migration_template("create_event_records.rb", "db/migrate", :migration_file_name => "create_event_records")
    end
  end
end
