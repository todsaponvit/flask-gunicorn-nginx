.
├── app
│   ├── static
│   └── templates
│   └── __init__.py
│   └── main.py
├── nginx
│   └── nginx.conf
├── Dockerfile
└── requirements.txt

docker build -t my-flask-app .

docker run -d -p 80:80 --name my-flask-instance my-flask-app
