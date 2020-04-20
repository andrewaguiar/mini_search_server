# Mini Search Server

A mini search server based on `mini_search` gem that uses postgres as secure storage and mini search
to implement textual searching.

## Configuration

  - **DATABASE_URL**: Postgresql database url.
  - **DEFAULT_CORE_LANG**: Default core lang support.
  - **DOCUMENT_TABLE_NAME**: The name of table used by mini search server to store documents in postgres default 'documents'.
  - **AUTH_TOKEN**: Authentication token passed via http header `AuthToken`.

## Endpoints

Mini Search Server follows restful style in its endpoints.

### Indexing a document

`POST /cores/:core/document/:id`

Params:
  - **core**: The core where the document lives.
  - **id**: Document id
  - **content**: Document content.

### Updating a document

`PUT /cores/:core/document/:id`

Params:
  - **core**: The core where the document lives.
  - **id**: Document id
  - **content**: Document content.

### Delete document by id

`DELETE /cores/:core/document/:id`

Params:
  - **core**: The core where the document lives.
  - **id**: Document id.

### Search documents by terms

`GET /cores/:core/documents -d "terms=Doge"`

Params:
  - **core**: The core where the document lives.
  - **terms**: Terms of search.

### Get document by id

`GET /cores/:core/document/:id`

Params:
  - **core**: The core where the document lives.
  - **id**: Document id.
