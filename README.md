[![Docker Image CI](https://github.com/mkrtchyan-t/aca-django-project/actions/workflows/docker-image.yml/badge.svg)](https://github.com/mkrtchyan-t/aca-django-project/actions/workflows/docker-image.yml)

# Django project

Infrastructure to deploy Djangoproject source code on a web page.

## Infrastructure Diagram

![project diagram drawio](https://user-images.githubusercontent.com/73377788/189150358-60f6c9b2-60a7-4da4-9d0d-f89a95309683.png)

## Getting Started

### Dependencies

* AWS CLI
* Terraform v1.2.8
* Ansible 2.13
* kubectl 1.22

<!-- ### Installing

* How/where to download your program
* Any modifications needed to be made to files/folders
 -->


### Executing program

* Generate keypair 

> Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
>
> In the navigation pane, under Network & Security, choose Key Pairs.
>
> On the Key Pairs page, choose Create Key Pair.
>
> For Key pair name, type a name that is easy for you to remember, and then choose Create.
>
> When the console prompts you to save the private key file, save it in _**infrastructure/key-pair**_ directory.

* Run `terraform init, terrafrom validate, terraform apply -auto-approve` in 01-ekscluster-terraform-manifets folder.

* Run the same commands in numbering order as they are named.

* Configure kubeconfig for kubectl
```
aws eks --region <region-code> update-kubeconfig --name <cluster_name>
aws eks --region us-east-1 update-kubeconfig --name devops-dev-eksdemo1
```
* Verify Kubernetes Worker Nodes using kubectl
```
kubectl get nodes -o wide
```

* List Pods
```
kubectl get pods -o wide
```

* List Services
```
kubectl get svc -o wide
```

* Apply deployment and load balancer service configs
```
kubectl apply -f 05-django-app-nlb-deplyomnet/
```

* Verifing Metrics Server
```
kubectl -n kube-system get deploy
kubectl -n kube-system get pods
kubectl -n kube-system logs -f <POD-NAME>
kubectl top pods -n kube-system
```

* Running load test in new window and keep running command `kubectl get hpa`
```
kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://app3-nginx-cip-service; done"
```

* Verify the pods count increased

<!-- ## Help

Any advise for common problems or issues.
```
command to run if program contains helper info
```
 -->
## Contributors

- [@David Vardanyan](https://github.com/daveInDevOps)
- [@Roland Bakunts](https://github.com/RolandBakunts)
- [@Ashot Janunts](https://github.com/AshJan14)

<!-- ## Version History

* 0.2
    * Various bug fixes and optimizations
    * See [commit change]() or See [release history]()
* 0.1
    * Initial Release -->

<!-- ## License

This project is licensed under the [NAME HERE] License - see the LICENSE.md file for details

## Acknowledgments

Inspiration, code snippets, etc.
* [awesome-readme](https://github.com/matiassingers/awesome-readme)
* [PurpleBooth](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
* [dbader](https://github.com/dbader/readme-template)
* [zenorocha](https://gist.github.com/zenorocha/4526327)
* [fvcproductions](https://gist.github.com/fvcproductions/1bfc2d4aecb01a834b46) -->
