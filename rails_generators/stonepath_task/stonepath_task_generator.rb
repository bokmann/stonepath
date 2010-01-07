class StonepathTaskGenerator < Rails::Generator::Base
  
  
  attr_accessor :name, :attributes
  
  def initialize(runtime_args, runtime_options = {})
    super
    usage if @args.empty?
    
    @name = @args.first
    @controller_actions = []
    @attributes = []
    
    @args[1..-1].each do |arg|
      if arg.include? ':'
        @attributes << Rails::Generator::GeneratedAttribute.new(*arg.split(":"))
      end
    end
    
    @attributes.uniq!
  end
  
  def manifest
    record do |m|
       m.template('generic_task.rb', "app/models/#{@name.tableize.singularize}.rb")
       m.migration_template("generic_task_migration.rb", "db/migrate", :migration_file_name => "create_#{@name.tableize}")
    end
  end
end
