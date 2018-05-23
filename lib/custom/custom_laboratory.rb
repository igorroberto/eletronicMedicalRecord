require 'jruby/synchronized'
require 'singleton'
require 'mongo'
require 'json'

module Tabula
  class LaboratoryTemplate
    include JRuby::Synchronized
    include Singleton

    def makeMongoConection()
      client = Mongo::Client.new('mongodb://127.0.0.1:27017/test')
      return client 
    end

    def insert(template)
      baseInstance = makeMongoConection()
      collection = baseInstance[:laboratory]
      #top, left, bottom, right
      doc = { CNPJ: template["CNPJ"], laboratoryName: template["laboratoryName"], responsableNumber: template["responsableNumber"], responsableName: template["responsableName"] }
      result = collection.insert_one(doc)

    end

    def update(template)
      baseInstance = makeMongoConection()
      collection = baseInstance[:template]
      #top, left, bottom, right
      template.each do |item|
        puts item
        puts "fimmm ^^^^"
        doc = { top: item["y1"], left: item["x1"], bottom: item["y2"], right: item["x2"] }
        result = collection.insert_one(doc)
      end
    
    end

    def select(template)
      baseInstance = makeMongoConection()
      collection = baseInstance[:laboratory]
      array = [];
    
      collection.find.each do |document|
        puts document
        array.push(document)
      end
      
      return array
    
    end

    def delete(document_id)
      baseInstance = makeMongoConection()
      collection = baseInstance[:laboratory]
      puts document_id
      collection.delete_one( { _id: BSON::ObjectId(document_id) } )
    end

    
   

   

   
  end
end
