module Cri
  struct IndexEntry
    property name : String
    property path : String
    property version : String

    def initialize(@name, @path, @version)
    end
  end

  class Index
    PATH = "~/.cri/index.cri"

    def self.load : Array(IndexEntry)
      path = File.expand_path(PATH)
      return [] of IndexEntry unless File.exists?(path)

      File.read_lines(path).map do |line|
        parts = line.split(" ", 3)
        IndexEntry.new(parts[0], parts[1], parts[2])
      end
    end

    def self.save(entries : Array(IndexEntry))
      path = File.expand_path(PATH)
      File.open(path, "w") do |file|
        entries.each do |entry|
          file.puts "#{entry.name} #{entry.path} #{entry.version}"
        end
      end
    end

    def self.find(name : String) : IndexEntry?
      load.find { |e| e.name == name }
    end
  end
end
