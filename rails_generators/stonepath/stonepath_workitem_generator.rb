class StonepathWorkitemGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      task_name = args[0]
       m.readme("workitem_readme.txt")
    end
  end
end