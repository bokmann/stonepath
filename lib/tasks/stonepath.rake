namespace :stonepath do

  desc "Generate state diagrams for all classes implementing WorkItem"
  task :diagrams => :environment do
    FileUtils.mkdir_p "#{RAILS_ROOT}/doc/stonepath/dot"
    FileUtils.mkdir_p "#{RAILS_ROOT}/doc/stonepath/png"
    workitems.each do |workitem|
      dot_file = File.join(RAILS_ROOT, 'doc', 'stonepath', 'dot', "#{workitem.to_s.tableize.singularize}.dot")
      png_file = File.join(RAILS_ROOT, 'doc', 'stonepath', 'png', "#{workitem.to_s.tableize.singularize}.png")
      File.open(dot_file, 'w') {|f| f.write(workitem.to_dot) }
      `dot -Tpng "#{dot_file}" > "#{png_file}"`
    end
    
    tasks.each do |task|
      dot_file = File.join(RAILS_ROOT, 'doc', 'stonepath', 'dot', "#{task.to_s.tableize.singularize}.dot")
      png_file = File.join(RAILS_ROOT, 'doc', 'stonepath', 'png', "#{task.to_s.tableize.singularize}.png")
      File.open(dot_file, 'w') {|f| f.write(task.to_dot) }
      `dot -Tpng "#{dot_file}" > "#{png_file}"`
    end
  end


private

  def self.workitems
    self.implementing_models("StonePath::WorkItem")
  end
  
  def self.tasks
    self.implementing_models("StonePath::SPTask")
  end
  
  def self.implementing_models(a_module)
    tasks = Array.new
    Dir[File.join(RAILS_ROOT, "app/models/**/*.rb")].each do |file_path|
      path, file = file_path.split("/models/")
      class_name = file.sub(/\.rb$/,'').camelize
      clazz = class_name.split('::').inject(Object) { |package, name| package.const_get(name) } rescue nil
      if clazz && clazz.included_modules.collect { |m| m.to_s }.include?(a_module) 
        tasks << clazz
      end rescue nil
    end
    tasks
  end
end