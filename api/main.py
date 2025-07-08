from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from SPARQLWrapper import SPARQLWrapper, JSON
from pydantic import BaseModel

app = FastAPI()

# CORS configuration to allow Flutter app to connect
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # For development only - restrict in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# GraphDB configuration
GRAPHDB_ENDPOINT = "http://localhost:7200/repositories/Final_W2W_Onto"

class QueryRequest(BaseModel):
    query: str


@app.post("/query")
async def execute_query(request: QueryRequest):
    try:
        sparql = SPARQLWrapper(GRAPHDB_ENDPOINT)

        sparql.setQuery(request.query)
        sparql.setReturnFormat(JSON)

        results = sparql.query().convert()
        return {"data": results}

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/sample-data")
async def get_sample_data():
    sample_query = """
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    SELECT ?subject ?predicate ?object
    WHERE {
      ?subject ?predicate ?object
    }
    LIMIT 10
    """
    return await execute_query(QueryRequest(query=sample_query))

