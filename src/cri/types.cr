module Cri
  struct DocMethod
   property name : String
   property signature : String
   property line : Int32
   property doc : String?
   property file : String
   
   def initialize(@name, @signature, @line, @doc = nil, @file)
   end
  end
  
  struct DocType
   property name : String
   property file : String
   property doc : String?
   property line : String
   property methods : Array(DocMethod)
   
   def intialize(@name, @file, @doc = nil, @line, @methods : [] of DocMethod)
   end
 end
 end