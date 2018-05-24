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

    def insert(template)
      baseInstance = makeMongoConection()
      collection = baseInstance[:template]
      array = [];
      #top, left, bottom, right
      template["template"].each do |item|
      
        aux = { top: item["y1"], left: item["x1"], bottom: item["y2"], right: item["x2"] }
        array.push(aux)
       
      end
      doc = { laboratorio: template["laboratoryId"], areas: array }
      result = collection.insert_one(doc)
    
    end

    def delete(document_id)
 
    end

    
   

   

   
  end
end
