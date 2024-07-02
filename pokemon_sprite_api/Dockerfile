FROM tiangolo/uvicorn-gunicorn:python3.9-slim

RUN mkdir /app
WORKDIR /app

COPY ./requirements.txt ./requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

COPY ./app/ ./

CMD ["python3", "app.py"]