Clair - OpenShift image and template
=============

Clair is an open source project for the static analysis of vulnerabilities in application containers (currently including appc and docker).
Check the [CoreOS Clair project on GitHub] (https://github.com/coreos/clair)


The purpose of this project is to make clair runnable on OpenShift.

Deploying on OpenShift
==================================================

### Create a new application

We want to use the new-app tool to create all of the necessary resource. Before you create a new application

- be sure that you have created a project for clair
- be sure that you have an installed and running PostgreSQL database with persistent volume in your project 

If you have all of the necessary prerequisite you can create the application with the following commands:

Change to the project what you want to use and where your PostgreSQL database is running:

`oc project <projectname>`

Download the template file from "ose-artifacts" subdirectory and create a new application:

```
oc new-app -f /path/to/the/template/file/clair-openshift-template.yaml \
   -p POSTGRES_USERNAME="<username>" \
   -p POSTGRES_PASSWORD="<password>" \
   -p POSTGRES_IP="<database_service_ip>" \
   -p POSTGRES_PORT="<database_port>" \
   -p POSTGRES_DATABASE="<database_name>" \
   -p IMAGE_SERVER=<registry_server:port> \
   -p IMAGE_STREAM_NAMESPACE="<namespace>" \
   -p IMAGE_NAME="clair-opensift" \
   -p IMAGE_STREAM_TAG="<clair-openshift-image-tag>"
```

> **Where the environment variables are:**

> - POSTGRES_USERNAME: PostgreSQL database user for connection
> - POSTGRES_PASSWORD: PostgreSQL database password for connection
> - POSTGRES_IP: Service IP of prepared PostgreSQL server
> - POSTGRES_PORT: Used TCP port for PostgreSQL database (5432)
> - POSTGRES_DATABASE: The name of the prepared database for clair
> - IMAGE_SERVER: Docker registry server where the image resides
> - IMAGE_STREAM_NAMESPACE: Namespace where the imagestream resides
> - IMAGE_NAME: Name of the image (clair-openshift)
> - IMAGE_STREAM_TAG: Tag for the imagestream

At the end of the deploy process OpenShift will scale up the application pod with the deployment config.


### Delete the installed application

First of all you have to change project where your clair-openshift is installed:

`oc project <projectname>`

Now you can delete all off the created resource with the following command:

`oc delete imagestream,deploymentconfig,route,service --selector="app=appagile-kafka-manager"`

At the end don't forget to delete the installed PostgreSQL database too.
