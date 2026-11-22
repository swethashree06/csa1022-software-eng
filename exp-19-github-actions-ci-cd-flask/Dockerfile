FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
# Heroku sets $PORT at runtime; default to 5000 elsewhere
ENV PORT=5000
CMD gunicorn --bind 0.0.0.0:$PORT app:app
