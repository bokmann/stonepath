class StonepathWorkitemGenerator < Rails::Generator::Base
  
  load File.expand_path( File.dirname(__FILE__)) + '/../../lib/stonepath/extensions/rails_generator_commands.rb'
  
  attr_accessor :name, :attributes
  
  def initialize(runtime_args, runtime_options = {})
    super
    usage if @args.empty?
    
    @name = @args.first
    @attributes = []  
    @args[1..-1].each do |arg|
      if arg.include? ':'
        @attributes << Rails::Generator::GeneratedAttribute.new(*arg.split(":"))
      end
    end
    @attributes.uniq!
    @controller_actions = all_actions
  end
  
  def manifest
    record do |m|
 
      m.directory "app/models"
      m.template "model.rb", "app/models/#{singular_name}.rb"
      m.migration_template "migration.rb", "db/migrate", :migration_file_name => "create_#{plural_name}"
      m.directory "test/unit"
      m.template "tests/#{test_framework}/model.rb", "test/unit/#{singular_name}_test.rb"
      m.directory "test/fixtures"
      m.template "fixtures.yml", "test/fixtures/#{plural_name}.yml"

      m.directory "app/controllers"
      m.template "controller.rb", "app/controllers/#{plural_name}_controller.rb"
      m.template "event_controller.rb", "app/controllers/#{singular_name}_events_controller.rb"
      
      m.directory "app/helpers"
      m.template "helper.rb", "app/helpers/#{plural_name}_helper.rb"
      
      m.directory "app/views/#{plural_name}"
      @controller_actions.each do |action|
        if File.exist? source_path("views/#{view_language}/#{action}.html.#{view_language}")
          m.template "views/#{view_language}/#{action}.html.#{view_language}", "app/views/#{plural_name}/#{action}.html.#{view_language}"
        end
      end
    
      if form_partial?
        m.template "views/#{view_language}/_form.html.#{view_language}", "app/views/#{plural_name}/_form.html.#{view_language}"
      end
    
      m.route_stonepath_workitems plural_name
      
      m.directory "test/functional"
      m.template "tests/#{test_framework}/controller.rb", "test/functional/#{plural_name}_controller_test.rb"
    end
  end
  
  def form_partial?
    actions? :new, :edit
  end
  
  def all_actions
    %w[index show new create edit update destroy]
  end
  
  def action?(name)
    @controller_actions.include? name.to_s
  end
  
  def actions?(*names)
    names.all? { |n| action? n.to_s }
  end
  
  def singular_name
    name.underscore
  end
  
  def plural_name
    name.underscore.pluralize
  end
  
  def class_name
    name.camelize
  end
  
  def object_id_name
    (class_name.tableize.singularize + "_id")
  end
  
  def plural_class_name
    plural_name.camelize
  end
  
  def controller_methods(dir_name)
    @controller_actions.map do |action|
      read_template("#{dir_name}/#{action}.rb")
    end.join("  \n").strip
  end
  
  def render_form
    if form_partial?
      if options[:haml]
        "= render :partial => 'form'"
      else
        "<%= render :partial => 'form' %>"
      end
    else
      read_template("views/#{view_language}/_form.html.#{view_language}")
    end
  end
  
  def items_path(suffix = 'path')
    if action? :index
      "#{plural_name}_#{suffix}"
    else
      "root_#{suffix}"
    end
  end
  
  def item_path(suffix = 'path')
    if action? :show
      "@#{singular_name}"
    else
      items_path(suffix)
    end
  end
  
  def item_path_for_spec(suffix = 'path')
    if action? :show
      "#{singular_name}_#{suffix}(assigns[:#{singular_name}])"
    else
      items_path(suffix)
    end
  end
  
  def item_path_for_test(suffix = 'path')
    if action? :show
      "#{singular_name}_#{suffix}(assigns(:#{singular_name}))"
    else
      items_path(suffix)
    end
  end
  
  def model_columns_for_attributes
    class_name.constantize.columns.reject do |column|
      column.name.to_s =~ /^(id|created_at|updated_at)$/
    end
  end
  
  def rspec?
    test_framework == :rspec
  end
  
protected
  
  def view_language
    options[:haml] ? 'haml' : 'erb'
  end
  
  def test_framework
    options[:test_framework] ||= default_test_framework
  end
  
  def default_test_framework
    File.exist?(destination_path("spec")) ? :rspec : :testunit
  end
  
  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    # opt.on("--skip-model", "Don't generate a model or migration file.") { |v| options[:skip_model] = v }
    #     opt.on("--skip-migration", "Don't generate migration file for model.") { |v| options[:skip_migration] = v }
    #     opt.on("--skip-timestamps", "Don't add timestamps to migration file.") { |v| options[:skip_timestamps] = v }
    #     opt.on("--skip-controller", "Don't generate controller, helper, or views.") { |v| options[:skip_controller] = v }
    #     opt.on("--invert", "Generate all controller actions except these mentioned.") { |v| options[:invert] = v }
    #     opt.on("--haml", "Generate HAML views instead of ERB.") { |v| options[:haml] = v }
    #     opt.on("--testunit", "Use test/unit for test files.") { options[:test_framework] = :testunit }
    #     opt.on("--rspec", "Use RSpec for test files.") { options[:test_framework] = :rspec }
    #     opt.on("--shoulda", "Use Shoulda for test files.") { options[:test_framework] = :shoulda }
  end
  
  # is there a better way to do this? Perhaps with const_defined?
  def model_exists?
    File.exist? destination_path("app/models/#{singular_name}.rb")
  end
  
  def read_template(relative_path)
    ERB.new(File.read(source_path(relative_path)), nil, '-').result(binding)
  end
  
  def banner
    <<-EOS
Creates a WorkItem as defined by the Stonepath Workflow Methodology
EOS
  end
end
