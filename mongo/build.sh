chmod +x init-data.sh
docker build -t my-mongo-image:latest .
docker tag my-mongo-image $dockerRegistryCredentials_USR/my-mongo-image
echo $dockerRegistryCredentials_PSW docker login -u $dockerRegistryCredentials_USR --password-stdin
docker push $dockerRegistryCredentials_USR/my-mongo-image:latest