# main.py
from fastapi import FastAPI, HTTPException
from SPARQLWrapper import SPARQLWrapper, JSON

app = FastAPI()

GRAPHDB_ENDPOINT = "http://localhost:7200/repositories/your-repo"
NAMED_GRAPH = "http://w2w_onto.com/init/acacia"

@app.get("/named-graph-data")
async def get_named_graph_data():
    try:
        sparql = SPARQLWrapper(GRAPHDB_ENDPOINT)
        
        # Set authentication if needed
        # sparql.setCredentials("username", "password")
        
        query = f"""
        SELECT ?subject ?predicate ?object
        FROM <{NAMED_GRAPH}>
        WHERE {{
          ?subject ?predicate ?object
        }}
        LIMIT 1000
        """
        
        sparql.setQuery(query)
        sparql.setReturnFormat(JSON)
        
        results = sparql.query().convert()
        return {"data": results}
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))