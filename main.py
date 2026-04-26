from fastapi import FastAPI, HTTPException

app = FastAPI()

# Route to check the status of the application
@app.get("/status")
async def read_status():
    return {"status": "running"}

# Route to create a new project
@app.post("/projects")
async def create_project(project: dict):
    # Implement project creation logic here
    return project

# Route to get a specific project by ID
@app.get("/projects/{id}")
async def read_project(id: int):
    # Implement logic to retrieve a project by ID here
    return {"id": id}

# Route to delete a project by ID
@app.delete("/projects/{id}")
async def delete_project(id: int):
    # Implement project deletion logic here
    return {"id": id, "message": "deleted"}