## terraform-gcloud docker image

This helper image contains:

* google cloud sdk
* terraform
* terraform provider pre-installed, stores at `/opt/offline-tf-providers`
    * hashicrop/google
    * hashicrop/google-beta
    * hashicrop/tls


```bash
$ docker build -t ssivart/terraform-gcloud:1.8 .
```

```
$ docker login
```

```
$ docker push ssivart/terraform-gcloud:1.8
```