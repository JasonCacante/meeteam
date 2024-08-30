# Meeteam

This is a Rails application for managing products. The project uses Docker and Docker Compose for containerization.

## Prerequisites

- Docker
- Docker Compose

## Getting Started

### Clone the Repository

git clone https://github.com/JasonCacante/meeteam.git

### Change Directory
cd meeteam

### Build and Run the Containers

docker-compose build
docker-compose up -d --wait

### To run the test
docker-compose run web rspec -fd

### To stop and delete the containers
docker-compose dow

### Accessing the Application
The application should now be running at http://localhost:3000

### To test the endpoint /products
http://localhost:3000/products method post (I like to use post because we don't expose the parameters in the url and they good as part of the body)
