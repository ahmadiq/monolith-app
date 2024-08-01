FROM python:3.11-alpine

WORKDIR /app

COPY src .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]