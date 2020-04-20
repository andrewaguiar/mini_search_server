# frozen_string_literal: true

get '/info' do
  Oj.dump(GetInfo.call)
end

post '/cores/:core/document/:id' do |core, id|
  respond(
    self,
    IndexDocument.call(core: core, id: id, content: params[:content])
  )
end

get '/cores/:core/documents' do |core|
  respond(
    self,
    SearchDocument.call(core: core, terms: params[:terms])
  )
end

get '/cores/:core/documents/:id' do |core, id|
  respond(
    self,
    GetDocument.call(core: core, id: id)
  )
end

delete '/cores/:core/document/:id' do |core, id|
  respond(
    self,
    DestroyDocument.call(core: core, id: id)
  )
end
