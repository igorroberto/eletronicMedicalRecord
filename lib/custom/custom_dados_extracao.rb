require 'jruby/synchronized'
require 'singleton'
require 'mongo'
require 'json'

module Tabula
  class DadosExtracao
    include JRuby::Synchronized
    include Singleton

    def makeMongoConection()
      client = Mongo::Client.new('mongodb://127.0.0.1:27017/saudedb')
      return client 
    end

    def insert(template)
      baseInstance = makeMongoConection()
      collection = baseInstance[:dadosExtracao]
      #top, left, bottom, right
      doc = { codigoPaciente: template["codigoPaciente"], propriedade: template["propriedade"], valor: template["valor"] }
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

    def select(template = nil)
      baseInstance = makeMongoConection()
      collection = baseInstance[:dadosExtracao]
      array = [];
    
      collection.find.each do |document|
        
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