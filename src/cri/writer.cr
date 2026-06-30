module Cri
  class Writer
    def self.write(type : DocType, path : String) 
      File.open(path, "w") do |file|
        file.puts "NAME #{type.name}"
        file.puts "FILE #{type.file}"
        file.puts "LINE #{type.line}"
        write_doc(file, type.doc)
        type.methods.each do |method|
          file.puts "METHOD #{method.name}"
          file.puts "SIGNATURE #{method.signature}"
          file.puts "FILE #{method.file}"
          file.puts "LINE #{method.line}"
          write_doc(file, method.doc, indent: " ")
          file.puts "END METHOD"
        end
      end
    end
    
    private def self.write_doc(file, doc, indent = "")
      file.puts "#{indent}Doc"
       if doc
         doc.each_line { |line| file.puts "#{indent}#{line}" } 
       end
       file.puts "#{indent}END_DOC"
     end
   end
    
          
          