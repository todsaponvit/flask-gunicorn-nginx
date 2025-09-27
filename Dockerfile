# Dockerfile
# Stage 1: Build a python environment
FROM python:3.9-slim AS build-env

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Create the final image
FROM nginx:alpine

# Install uWSGI and necessary build dependencies
RUN apk add --no-cache python3 py3-pip uwsgi uwsgi-python3

WORKDIR /app
COPY --from=build-env /usr/local/lib/python3.9/site-packages/ /usr/local/lib/python3.9/site-packages/
COPY --from=build-env /usr/local/bin/ /usr/local/bin/
COPY . /app

# Copy the Nginx configuration
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# uWSGI configuration file
COPY uwsgi.ini /etc/uwsgi/uwsgi.ini

EXPOSE 80

# Use a shell script to start both services
COPY start.sh /start.sh
CMD ["/start.sh"]
