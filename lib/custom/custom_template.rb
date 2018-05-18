require 'jruby/synchronized'
require 'singleton'
require 'mongo'
require 'json'

module Tabula
  class CustomTemplate
    include JRuby::Synchronized
    include Singleton

    def makeMongoConection()
      client = Mongo::Client.new('mongodb://127.0.0.1:27017/test')
      return client 
    end

    def insert_template(template)
      baseInstance = makeMongoConection()
      collection = baseInstance[:template]

      template.each do |item|
        puts item
        puts "fimmm ^^^^"
        doc = { top: item["y1"], right: item["x1"], bottom: item["y2"], left: item["x2"] }
        result = collection.insert_one(doc)
      end
    
    end

    def delete_document(document_id)
 
    end

    
   

   

   
  end
end
