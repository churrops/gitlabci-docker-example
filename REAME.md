Autor: Rodrigo Floriano (ChurrOps)


#### 1. Possuir ou criar uma conta no DockerHub ou em algum outro registry


#### 2. Criar um repositório para a imagem que será utilizada nesse exemplo

#### 3. Clonar o projeto

```
git clone
cd gitlabci-docker-example
```

Criar o arquivo ".gitlab-ci.yml" na raiz do projeto

```
vim .gitlab-ci.yml
```

```
image: docker:18

stages:
  - build

variables:
  CI_REGISTRY_URL:  # index.docker.io/v1
  CI_REGISTRY_USER: YOUR_REGISTRY_USER
  CI_REGISTRY_PASSWORD: 'YOUR_REGISTRY_PASS'
  CI_REGISTRY_IMAGE: 'YOUR_REGISTRY_IMAGE_PATH' #rodrigochurrops/awesome-ci
  CI_REGISTRY_IMAGE_FULL: $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_NAME-$CI_COMMIT_SHORT_SHA

services:
  - docker:dind

before_script:
  - >
    echo -n $CI_REGISTRY_PASSWORD | docker login
    -u $CI_REGISTRY_USER
    --password-stdin $CI_REGISTRY

build:
  stage: build
  script:
    - docker pull $CI_REGISTRY_IMAGE:latest || true
    - docker build --pull -t $CI_REGISTRY_IMAGE_FULL .
    - docker image ls
    - echo $CI_REGISTRY_IMAGE_FULL
#    - /bin/sh ./tests/test-up-and-run.sh
    - docker run -d --name nginx -p 80:80 $CI_REGISTRY_IMAGE_FULL curl localhost
    - docker rm -f nginx
    - docker push $CI_REGISTRY_IMAGE_FULL
```

Entrar no diretório do gitlab e criar os diretórios de dados

```
cd gitlab

mkdir -p gitlab/config gitlab/logs gitlab/data

mkdir -p gitlab-runner/config
```

Download das imagens do gitlab e do gitlab-runner

```
docker pull gitlab/gitlab-ce:12.0.2-ce.0

docker pull gitlab/gitlab-runner:v12.0.1
```

Subir o projeto do gitlab

```
docker-compose up -d
```

