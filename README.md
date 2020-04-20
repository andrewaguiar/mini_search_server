# Mini Search Server

A mini search server based on `mini_search` gem that uses postgres as secure storage and mini search to implement
textual searching.

## Configuration

Envs:
  - **DATABASE_URL**: Postgresql database url.
  - **DEFAULT_CORE_LANG**: Default core lang support.

## Endpoints

### Indexing a document

POST `/cores/:core/document/:id`

Params:
  - **core**: The core where the document lives.
  - **id**: Document id
  - **content**: Document content.


### Search documents by terms

GET `/cores/:core/documents` -d "terms=Doge"

Params:
  - **core**: The core where the document lives.
  - **terms**: Terms of search.


### Get document by id

GET `/cores/:core/document/:id`

Params:
  - **core**: The core where the document lives.
  - **id**: Document id.


### Delete document by id

DELETE `/cores/:core/document/:id`

Params:
  - **core**: The core where the document lives.
  - **id**: Document id.
