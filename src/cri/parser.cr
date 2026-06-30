module Cri
  class Parser
    def self.parse(path : String) : DocType
      lines = File.read_lines(path)
      parse_type(lines)
    end
    
    def self.parse_type(lines : Array(String)) : DocType
      name = extract_value(lines.shift)
      file = extract_value(lines.shift)
      line = extract_value(lines.shift).to_i
      doc = parse_doc(lines)
      methods = [] of DocMethod
      while lines.any? && lines.first.starts_with?("METHOD")
        methods << parse_method(lines)
      end
      DocType.new(name, file, line, doc, methods)
    end
    
    private def self.parse_method(lines : Array(String)) : DocMethod
    name = extract_value(lines.shift)
    signature = extract_value(lines.shift)
    file = extract_value(lines.shift)
    line = extract_value(lines.shift).to_i
    doc = parse_doc(lines.shift)
    lines.shift
    DocMethod.new(name, signature, line, doc, file)
   end
   
   private def self.parse_doc(lines : String) : String?
    lines.shift
    doc_lines = [] of String
    while lines.any? && lines.first.starts_with?("END_DOC")
      doc_lines << lines.shift
    end
    
    lines.shift
    
    doc_lines.empty? ? nil : doc_lines.join("\n")
    end
    
    private def self.extract_values(lines : String) String
     lines.split(" ", 2)[1]
   end
 end
 end