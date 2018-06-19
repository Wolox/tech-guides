# Deploying front-ends to Azure

## Introduction

This document is intended to be a guideline for deploying a frontend static site to Azure.

There are two main ways of deploying a static website to Azure. The first one and also the more expensive is using a Web App.
Since the cost of computational instances is highly superior to that of static storage, it is recommended to use a blob container instead.

## Using a blob container

Currently, blob containers lack some functions that s3 buckets have. For example, you can't set a default index file or use an SSL certificate. To deal with this, we can create a Function Proxy.

### Creating the blob container

* From the Azure's main portal, go to `Create a Resource` -> `Storage` -> `Storage Account`
* Choose a name, in `Account kind` choose `Blob Storage` and set `Access Tier` to `Hot`.
* You can add the container to an existent resource group or create a new one for this application.
* The rest of the options can be left default.
* To host a website, it must be inside a container inside $root, so go to `Storage Accounts` -> `Containers` and choose to add a container inside root, you will have to choose `Container` in `Public Access level` so the container's content can be publicly accessed.

### Uploading your site to the container
* There are two main tools to upload your files: [Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/) or [AzCopy](https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-linux)
* Using AzCopy, you can sync your build folder by running `azcopy --recursive --source <build folder> --destination <blob url>/<container name>  --dest-key <access key> --set-content-type text/html`.

Since Azure doesn't automatically detect the appropriate `Content-Type` for each file, we have to upload each file separately, manually specifying each `Content-Type`. To do this, replace set variables at the beginning of the script and run the following script. In case your site has other type of files, you will have to manually upload them setting the appropriate `Content-Type`.

```
export BUILD_FOLDER= <build folder>
export CONTAINER_URL= <blob url>/<container name>
export ACCESS_KEY= <access key>
azcopy --recursive --source $BUILD_FOLDER --destination $CONTAINER_URL  --dest-key $ACCESS_KEY --quiet
azcopy --recursive --source $BUILD_FOLDER --destination $CONTAINER_URL  --dest-key $ACCESS_KEY --set-content-type text/html --include "*.html" --quiet
azcopy --recursive --source $BUILD_FOLDER --destination $CONTAINER_URL  --dest-key $ACCESS_KEY --set-content-type image/svg+xml --include "*.svg" --quiet
azcopy --recursive --source $BUILD_FOLDER --destination $CONTAINER_URL  --dest-key $ACCESS_KEY --set-content-type image/jpeg --include "*.jpg" --quiet
azcopy --recursive --source $BUILD_FOLDER --destination $CONTAINER_URL  --dest-key $ACCESS_KEY --set-content-type image/jpeg --include "*.jpeg" --quiet
azcopy --recursive --source $BUILD_FOLDER --destination $CONTAINER_URL  --dest-key $ACCESS_KEY --set-content-type image/png --include "*.png" --quiet
azcopy --recursive --source $BUILD_FOLDER --destination $CONTAINER_URL  --dest-key $ACCESS_KEY --set-content-type application/javascript --include "*.js*" --quiet
azcopy --recursive --source $BUILD_FOLDER --destination $CONTAINER_URL  --dest-key $ACCESS_KEY --set-content-type text/css --include "*.css" --quiet
azcopy --recursive --source $BUILD_FOLDER --destination $CONTAINER_URL  --dest-key $ACCESS_KEY --set-content-type image/x-icon --include "*.ico" --quiet
```

Where the access key can be obtained from `Storage Accounts` -> `Access Keys`

### Making your site accessible
Since containers are designed to host only files and not static websites, we will need to use a proxy function to allow us to route the site.
To create it, go to `Create a Resource` -> `Compute` -> `Function App`, give it a name,   leave the rest as default
* Go to `Proxies` choose `+`, give it a name, set / as `Route Template`, for allowed HTTP methods choose `GET` and in `Backend URL`, choose your containers index url.
* Go to Proxies, Advanced Editor and edit the `proxies.json` file, change it's content for the following, replacing `<blob url>/<container name>` with your container url.

Also, this file is written for React front-ends that have a `static` folder. For other projects, you have to create proxy objects for each static asset folder present.

```
{
    "$schema": "http://json.schemastore.org/proxies",
    "proxies": {
        "root": {
            "matchCondition": {
                "route": "/"
            },
            "backendUri": "https://<blob url>/<container name>/site/index.html"
        },
        "static": {
            "matchCondition": {
                "route": "/static/{*restOfPath}"
            },
            "backendUri": "https://<blob url>/<container name>/site/static/{restOfPath}"
        },
        "css": {
            "matchCondition": {
                "route": "/static/css/{*restOfPath}"
            },
            "backendUri": "https://<blob url>/<container name>/site/static/css/{restOfPath}"
        },
        "js": {
            "matchCondition": {
                "route": "/static/js/{*restOfPath}"
            },
            "backendUri": "https://<blob url>/<container name>/site/static/js/{restOfPath}"
        },
         "media": {
            "matchCondition": {
                "route": "/static/media/{*restOfPath}"
            },
            "backendUri": "https://<blob url>/<container name>/site/static/media/{restOfPath}"
        },
        "vendor": {
            "matchCondition": {
                "route": "/js/vendor/{*restOfPath}"
            },
            "backendUri": "https://<blob url>/<container name>/site/js/vendor/{restOfPath}"
        },
        "level1root": {
            "matchCondition": {
                "route": "/{level1}"
            },
            "backendUri": "https://<blob url>/<container name>/site/index.html"
        },
        "level2root": {
            "matchCondition": {
                "route": "/{level1}/{level2}"
            },
            "backendUri": "https://<blob url>/<container name>/site/index.html"
        },
        "level3root": {
            "matchCondition": {
                "route": "/{level1}/{level2}/{level3}"
            },
            "backendUri": "https://<blob url>/<container name>/site/index.html"
        },
        "level4root": {
            "matchCondition": {
                "route": "/{level1}/{level2}/{level3}/{level4}"
            },
            "backendUri": "https://<blob url>/<container name>/site/index.html"
        },
        "level1": {
            "matchCondition": {
                "route": "/{level1}/{*restOfPath}"
            },
            "backendUri": "https://<blob url>/<container name>/site/index.html"
        },
        "level2": {
            "matchCondition": {
                "route": "/{level1}/{level2}/{*restOfPath}"
            },
            "backendUri": "https://<blob url>/<container name>/site/index.html"
        },
        "level3": {
            "matchCondition": {
                "route": "/{level1}/{level2}/{level3}/{*restOfPath}"
            },
            "backendUri": "https://<blob url>/<container name>/site/index.html"
        },
        "level4": {
            "matchCondition": {
                "route": "/{level1}/{level2}/{level3}/{level4}/{*restOfPath}"
            },
            "backendUri": "https://<blob url>/<container name>/site/index.html"
        },
        "restofpath": {
            "matchCondition": {
                "route": "{*restOfPath}"
            },
            "backendUri": "https://<blob url>/<container name>/site/{restOfPath}"
        }
    }
}
```
