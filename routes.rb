# frozen_string_literal: true

get '/info' do
  Oj.dump(GetInfo.call)
end

# Search documents
get '/cores/:core/documents' do |core|
  respond(
    self,
    SearchDocument.call(core: core, terms: params[:terms])
  )
end

# Get document by core and id
get '/cores/:core/documents/:id' do |core, id|
  respond(
    self,
    GetDocument.call(core: core, id: id)
  )
end

# Index document
post '/cores/:core/document/:id' do |core, id|
  respond(self,
    IndexDocument.call(core: core, id: id, content: params[:content])
  )
end

# Update document
put '/cores/:core/document/:id' do |core, id|
  respond(self,
    UpdateDocument.call(core: core, id: id, content: params[:content])
  )
end

# Delete document by id
delete '/cores/:core/document/:id' do |core, id|
  respond(
    self,
    DestroyDocument.call(core: core, id: id)
  )
end
