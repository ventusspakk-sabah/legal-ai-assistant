from fastapi import FastAPI, File, UploadFile
from fastapi.responses import HTMLResponse
import pytesseract
from PIL import Image
import io

app = FastAPI()

@app.post("/uploadfile/")
async def upload_file(file: UploadFile = File(...)):
    # Read the image file as a binary stream
    contents = await file.read()
    image = Image.open(io.BytesIO(contents))
    # Use pytesseract to extract text from image
    extracted_text = pytesseract.image_to_string(image)
    return {"filename": file.filename, "text": extracted_text}

@app.get("/uploadfile/", response_class=HTMLResponse)
async def upload_file_form():
    return '''<!DOCTYPE html>
    <html>
        <body>
            <form action="/uploadfile/" enctype="multipart/form-data" method="post">
                <input name="file" type="file" />
                <button type="submit">Upload</button>
            </form>
        </body>
    </html>'''