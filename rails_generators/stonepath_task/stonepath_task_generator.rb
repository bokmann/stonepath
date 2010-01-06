class StonepathTaskGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      task_name = args[0]
       m.template('generic_task.rb', "app/models/#{task_name}.rb")
       m.migration_template("generic_task_migration.rb", "db/migrate", :migration_file_name => "create_#{task_name.tableize}")
    end
  end
end
