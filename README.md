# openshift-proxy

Template for running a proxy on a container based on apache on alpine linux/openshift/docker.

### Installation

You need oc (https://github.com/openshift/origin/releases) locally installed:

create a new project (change to your whishes) or add this to your existing project

```sh
oc new-project openshift-proxy \
    --description="Proxy - Apache" \
    --display-name="Proxy"
```

Deploy (externally)

```sh
oc new-app https://github.com/weepee-org/openshift-webproxy.git --name proxy
```

Deploy (weepee internally)
add to Your buildconfig
```yaml
spec:
  strategy:
    dockerStrategy:
      from:
        kind: ImageStreamTag
        name: proxy-server:latest
        namespace: weepee-registry
    type: Docker
```
use in your Dockerfile
```sh
FROM weepee-registry/proxy-server

# Your app
ADD conf /conf
```

#### Route.yml

Create route for development and testing

```sh
curl https://raw.githubusercontent.com/ure/openshift-webproxy/master/Route.yaml | oc create -f -
```
