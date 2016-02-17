require 'yaml'
require 'mustache'
require 'pry'

collection_no = ARGV[0]
puts collection_no


def load_tempalates()
    Dir.glob('templates/*.mustache').inject({}) do |lookup,file|
      name = file.split("/")[-1].split(".")[0]
      template = IO.read(file)
      lookup[name] = template
      return lookup
    end
end


templates = load_tempalates()
collection_data = YAML.load(IO.read("collections/descriptions/collection_description_#{collection_no}.yaml"))

index_html = Mustache.render(templates['index'], collection_data)
index_file = "collections/#{collection_no}/index.html"
File.open(index_file,'w'){|f| f.puts index_html}
puts "writing #{index_file}"
