We will eventually have a real generator here that will even include some default config for AASM settings, restful routes for the workflow actions, etc.  Until then, it would be best to start a workitem by:

1) Using scaffold generator
2) adding aasm_state:string and owner_id:integer to the migration.
3) adding:

  require 'aasm'
  require 'stonepath'

  stonepath_workitem

  to the model

4) defining a state machine.