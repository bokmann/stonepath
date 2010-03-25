module StonePath
  module Dot
    
    def to_dot
      dot = ""
      
      dot << "digraph x {\n"
      dot << "\trankdir=LR\n"
      dot << "\tnode [fontname=Helvetica,fontcolor=blue]\n"
      aasm_states.each do |state|
        dot << "\t#{state.name.to_s.camelize.singularize}\n"
      end
      
      dot << "\tedge [fontname=Helvetica,fontsize=10]\n"
      aasm_events.each do |name, event|
        event.all_transitions.each do |t|
          from = t.opts[:from].to_s.camelize.singularize
          to = t.opts[:to].to_s.camelize.singularize
          if from == to
            extras = "headport=e tailport=s]"
          else
            extras = ""
          end
          dot << "\t#{from} -> #{to} [label=\"#{name.to_s.humanize}\" arrowhead=vee"
          dot << extras
          dot << "]\n"
        end
      end
      dot << "}\n"
      dot
    end
    
  end
end
