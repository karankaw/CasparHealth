### N.B.
- I know this README File is a bit longer than usual, but just wanted to express my intents/choices/tradeoff more clearly here, please pardon me.
- [Design Choices](#design-choices)
- [Notes](#notes)
- [Miscellaneous](#miscellaneous)
- [DockerCompose Kubectl Migration Steps](#dockercompose-kubectl-migration-steps)

### Design Choices
- `Github URL` : https://github.com/karankaw/CasparHealth
- *Tools Used* : Minikube, Kompose(Optional), Kubectl, Git
- I have built and used images locally inside minikube itself.
	* Docker Images are not uploaded to Private Repo - Could have done that too.
- Its a a best practice to have resources scoped to a K8 namespace, but I have used 'default' namespace, so as to be closer to provided boilerplate code
- Both'api' and 'spa' services have hostFiles baked in them. Still, I chose to deliberately include 'Hostpath' Volume for API just to show that we can do it that way too.
  * I mounted Hostpath also via minikube `minikube mount`
- I have kept all Services as ClusterIP for keeping it simple and exposed it using kubectl port-forward* or ``` minikube service --url```
  * Could have made that `NodePort/LoadBalancer` as well.
- I have used Kompose on existing code, just to get some skeleton code/shims and then refactored it.
- Please go through my inline Comments in YAML for more insights.
- I have used Secrets(BASE64 Encoded) and Congigmap and populated them as ENV
  * Ideally, We should Mount Secrets as Volume (Will need to change code too) or use ```Vault``` 'Azure KeyVault' or 'AWS Secrets Manager'
- PersistentVolume for PostgresDB - I have used PVC and Minikube had a Default Storage Class which dynamically created PV for me.
- "spa" service has 2 Volumes in Docker-Compose, but they are already baked in Image, So I did not added any volume "spa"
- Created Kubernetes Job to run *rake* tasks for intial Database Bootstrapping 

### Notes
- ```Minikube``` should be installed
- Hardware Used : **M1 Macbook Air**
- I have no prior knowledge of Ruby-On-Rails and Github Actions
- I could easily use any Python/ROR based project and get it linked with PostgreSQL/Redis 
  * But I was more interested in tackling provided BoilerPlate Code shared as [BoilerPlateCode Link](https://drive.google.com/file/d/1Vm3U14jhnC0enw0leWoCrE3j_VNh8RoB/view)
- I followed README.md and ran Docker-Compose, I opened http://localhost:8000
	* "Category" Dropdown in "Video Library" had no items in it - Please refer screenshot 
	[DockerCompose-Err1.png](https://github.com/karankaw/CasparHealth/blob/main/misc/CategoryMissing-Error-DockerCompose.png)
- I am able to get "Welcome to RAILS" Homepage as well for 'api' service
- I am able to get "Video Library" Homepage as well for 'spa' service
  * My Kubernetes App also shows same behaviour that "Category" dropdown shows in DockerCompose as mentioned earlier above and it also does not get populated and video cannot be submiited.
- `sidekiq` is same as `api` docker image, but I still kept them separately tagged.


### Miscellaneous 
- I learned to write good Markdown while doing this coding assignment
- My next course of action could be automate steps mention below in "Github Actions", Need to learn "Github Actions"

___
### DockerCompose Kubectl Migration Steps
* **Use kompose convert** : (Optional)This gives us intial skeleton yamls and then we refactor them comparing docker-compose.yml
* **Point Docker CLI to Minikube's DockerEngine** : So that we can use images Locally without pull
* **Create Mounts** : Using `minikube mount` for 'api' hostpath Volume
* **Apply Kubernetes Manifest** : from k8 folder
* **Run Kubernetes Job** for Database Migration *rake* commands
* **port-forward** : Forward K8 Services using `k8 port-forward` or `minikube service` so that we can test URLs

*RUN Steps (To be Automated soon in Github Actions)*
```shell
git clone https://github.com/karankaw/CasparHealth
cd CasparHealth
minikube status # Minikube should be running
kubectl config current-context # Kubectl should be pointing to minikube

minikube mount code-challenge-0.1.1/api/:/home/docker/api # Keep this bash Shell Running

# Open New Bash Shell/Tab to 'CasparHealth' folder
minikube ssh  # Get In Minikube Host/Node
pwd           # Should show /home/docker
ls            # Should list 'api' Folder
ls api        # Should list files and directories

# Open New Bash Shell/Tab to 'CasparHealth' folder
eval $(minikube docker-env)
echo $DOCKER_HOST   # ENV Variable Should be set

cd code-challenge-0.1.1
docker build . -t code-challenge-011-api:latest -f Dockerfile.rails  
docker build . -t code-challenge-011-sidekiq:latest -f Dockerfile.rails  # sidekiq is same as api image
docker build . -t code-challenge-011-spa:latest -f Dockerfile.react
docker build . -t code-challenge-011-nginx:latest -f Dockerfile.nginx
docker image ls     # Should show images including above 3, we just built

cd ../k8
kubectl apply -f . # Wait sometime for changes to take effect

kubectl get all
kubectl get pv
kubectl get pvc
kubectl get secrets
kubectl get cm

#kubectl port-forward svc/api 8080:3000    # My Defined port could be running elsewhere
#kubectl port-forward svc/nginx 8082:8000  # So using minikube service

# Open New Bash Shell/Tab 
minikube service api --url


# Open New Bash Shell/Tab 
minikube service nginx --url

#When done completely, You can destroy minikube
minikube delete
```

Please Refer Screenshots of my work
