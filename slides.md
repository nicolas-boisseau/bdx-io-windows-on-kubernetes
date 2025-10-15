---
layout: cover
background: './resources/bdxio-kit-communication/illustrations/bridge-background-blue-large.png'
theme: seriph
title: Oui, Kubernetes peut faire tourner vos applis Windows. Sérieusement.
info: |
  ## BDX.IO 2025
  Présentation sur la containerisation d'applications Windows legacy dans Kubernetes
titleTemplate: '%s - BDX.IO 2025'
class: text-center
drawings:
  persist: false
transition: slide-left
mdc: true
highlighter: shiki
lineNumbers: true
colorSchema: 'dark'
addons:
  - fancy-arrow
---

# Oui, Kubernetes peut faire tourner vos applis Windows. Sérieusement.

<div class="flex justify-center">
  <p>
     <logos:microsoft-icon class="text-5xl inline-block mr-2" />  <carbon:add class="text-5xl inline-block mx-2" /> <logos:kubernetes class="text-5xl inline-block ml-2" /> <carbon:binding-01 class="text-5xl inline-block mx-2" /> <carbon-favorite-filled class="text-red-500 text-5xl inline-block mx-2" />
  </p>
</div>

<div class="flex justify-center">
  <img src="/resources/bdxio-kit-communication/logo/logo-blanc.png" class="h-30 mx-auto my-5" />
</div>

<!--
Notes du présentateur: Introduction personnelle et remerciement à BDX.IO
-->

---
layout: full
---

# Présentation

<div class="flex gap-5 mt-30 mb-10">
  
  <div class="text-left mt-5 mr-2">
    <h2 class="text-3xl font-bold">Nicolas Boisseau</h2>
    <p class="text-lg">Staff Engineer @ Peaksys</p>
    <p class="text-sm italic">#Azure #Kubernetes #DevOps #FinOps #Archi</p>
  </div>
  <img src="/resources/nbo_ghibli.png" class="h-40 rounded-full border-4 border-white/20" />
</div>

<div class="absolute top-55 right-15">
<img src="/resources/peaksys_it_cdiscount_white.png" class="h-28" />
</div>

<!--
Role chez Peaksys
-->

---

# L'avènement des Windows Containers

<v-switch>
  <template #1>

<div>
```mermaid
---
config:
  logLevel: 'debug'
  themeVariables:
    cScale0: '#19D3A6'
    cScaleLabel0: '#000000'
    cScale1: '#FFD917'
    cScaleLabel1: '#000000'
    cScale2: '#7D7DF8'
    cScaleLabel2: '#ffffff'
---
    timeline
        2015 : Introduction Windows Server Containers (Docker + Windows Server 2016 TP)
```
</div>

  </template>
  <template #2>

<div>
```mermaid
---
config:
  logLevel: 'debug'
  themeVariables:
    cScale0: '#19D3A6'
    cScaleLabel0: '#000000'
    cScale1: '#FFD917'
    cScaleLabel1: '#000000'
    cScale2: '#7D7DF8'
    cScaleLabel2: '#ffffff'
---
    timeline
        2015 : Introduction Windows Server Containers (Docker + Windows Server 2016 TP)
        Mars 2019 : Kubernetes v1.14 - GA des nœuds Windows
```
</div>

  </template>
  <template #3>

<div>
```mermaid
---
config:
  logLevel: 'debug'
  themeVariables:
    cScale0: '#19D3A6'
    cScaleLabel0: '#000000'
    cScale1: '#FFD917'
    cScaleLabel1: '#000000'
    cScale2: '#7D7DF8'
    cScaleLabel2: '#ffffff'
---
    timeline
        2015 : Introduction Windows Server Containers (Docker + Windows Server 2016 TP)
        Mars 2019 : Kubernetes v1.14 - GA des nœuds Windows
        Mai 2020 : AKS - GA du support Windows Server nodes

```
</div>

  </template>
  <template #4>

<div>
```mermaid
---
config:
  logLevel: 'debug'
  themeVariables:
    cScale0: '#19D3A6'
    cScaleLabel0: '#000000'
    cScale1: '#FFD917'
    cScaleLabel1: '#000000'
    cScale2: '#7D7DF8'
    cScaleLabel2: '#ffffff'
---
    timeline
        2015 : Introduction Windows Server Containers (Docker + Windows Server 2016 TP)
        Mars 2019 : Kubernetes v1.14 - GA des nœuds Windows
        Mai 2020 : AKS - GA du support Windows Server nodes : En parallèle, 1ère version de notre environnement Sandbox

```
</div>

  </template>
    <template #5>

<div>
```mermaid
---
config:
  logLevel: 'debug'
  themeVariables:
    cScale0: '#19D3A6'
    cScaleLabel0: '#000000'
    cScale1: '#FFD917'
    cScaleLabel1: '#000000'
    cScale2: '#7D7DF8'
    cScaleLabel2: '#ffffff'
    cScale3: '#FFD917'
    cScaleLabel3: '#000000'
---
    timeline
        2015 : Introduction Windows Server Containers (Docker + Windows Server 2016 TP)
        Mars 2019 : Kubernetes v1.14 - GA des nœuds Windows
        Mai 2020 : AKS - GA du support Windows Server nodes : En parallèle, 1ère version de notre environnement Sandbox
        2021-2022 : Revue FinOps & Optimisations des coûts Azure
```
</div>

  </template>
</v-switch>


---
layout: two-cols-header
transition: slide-up
---

# Un peu de contexte : un cas pratique

## Notre plateforme de paiement SaaS : un système hybride

::left::
<div class="m-5 mt--20">
  <img src="/resources/ecosystem_win.png" class="h-50 mr-5 float-left" />

  <ul class="text-4">
    <li class="mb-5">Backend Windows-only<br/>(.NET Framework, IIS)</li>
    <li>Traditionnellement installé sur des VM</li>
  </ul>
</div>

::right:: 

<div class="m-5 mt--20">
  <img src="/resources/ecosystem_tux.png" class="h-50 mr-5 float-left" />

 <ul class="text-4">
        <li class="mb-5">Backend moderne<br/>(.NET Core, Node.js, etc.)</li>
        <li>Conteneurisé (Docker)</li>
        <li>Déployé dans Kubernetes</li>
      </ul>
</div>

---

# Environnement Cloud Azure

## Hébergement hybride

<div class="grid grid-cols-3 gap-3">

  <div class="col-span-2">

<!--
Animations sur du mermaid : workaround avec un v-switch
https://github.com/slidevjs/slidev/issues/1498
-->

  <v-switch>
    <template #1>      
```mermaid
architecture-beta
    group vnet(azure:virtual-networks)[VNET]
    service user(carbon:user)[User Browser]
    service lb(azure:application-gateways)[App GW] in vnet
    service appService(azure:app-services)[App Services] in vnet
    user:R -- L:lb
    lb:R -- L:appService
```
    </template>
    <template #3>
```mermaid
architecture-beta
    group vnet(azure:virtual-networks)[VNET]
    service user(carbon:user)[User Browser]
    service lb(azure:application-gateways)[App GW] in vnet
    service appService(azure:app-services)[App Services] in vnet
    service lb_aks(azure:application-gateways)[App GW AKS with Ingress Controller] in vnet
    service aks(azure:kubernetes-services)[AKS Cluster] in vnet
    user:R -- L:lb
    lb:R -- L:appService
    user:B --> L:lb_aks
    lb_aks:R --> L:aks    
```
   </template>
  </v-switch> 
</div>

  <div class="">
   <img v-motion
  :initial="{ x: 1000 }"
  :enter="{ x: 0, y: -80 }"
  :duration="300" src="/resources/ecosystem_win.png" class="h-50 mx-auto" />
  <FancyArrow from="(720, 150)" to="(550, 220)" color="white" width="4" roughness="2"  v-click="1" />

<img v-motion
  :initial="{ x: 1000 }"
  :click-2="{ x: 0, y: -80 }"
  :duration="300" src="/resources/ecosystem_tux.png" class="h-50 mx-auto" />
  <FancyArrow from="(690, 350)" to="(550, 380)" color="white" width="4" roughness="2" v-click="3"  />
  

  </div>
</div>


<!--
Notes du présentateur: Agenda de la présentation
-->

---
layout: image-left
image: /resources/double_hosting_legacy_and_modern.png
---

# Ca ne va pas ?

<table>
<thead>
  <tr>
    <td>
      <img src="/resources/bdxio-kit-communication/illustrations/scribble-yellow.png" class="w-10 float-left" />
      <span class="text-sm text-yellow-500 pl-2">Legacy</span>
    </td>
    <td>
      <img src="/resources/bdxio-kit-communication/illustrations/scribble-turquoise.png" class="w-10 float-left" />
      <span class="text-sm text-turquoise-500 pl-2">Moderne</span>
    </td>
  </tr>
  </thead>
  <tbody>
  <tr>
    <td class="text-sm">
      Packaging .zip<br/>
      Pipelines App Services<br/>
      Logs fichiers dans les App Services<br/>
      Ecosystème AppService<br/>
    </td>
    <td class="prose-sm">
      Images Docker<br/>
      Pipelines Helm -> AKS<br/>
      Logs via stdout/stderr<br/>
      Ecosystème Kubernetes<br/>
    </td>
  </tr>

  <tr >
    <td class="text-lg text-center" colspan="2">
      <span v-mark="{ at:1, color: 'red', type: 'highlight' }">
        Maintenance globale       
        <strong class="text-xl">x2</strong>
      </span>
      <br/>
      (infra, packaging, pipelines, monitoring, etc.)
    </td>
  </tr>
  </tbody>
  
</table>

<!--
<div>
#### Pour le legacy

- Packages .zip
- Pipelines App Services
- Logs fichiers dans les App Services

</div>
  

<div v-click>

#### Pour le moderne

  - Images Docker
  - Helm Charts
  - Pipelines AKS
  - Logs via stdout/stderr
  - Monitoring via Azure Monitor et Log Analytics

</div>
-->

---
layout: image-left
# the image source
image: /resources/aks_windows.png
---

# Idée FinOps : et si on pouvait tout mettre dans Kubernetes ?

<v-clicks>

- 1 seul Application gateway, avec Ingress Controller (AGIC)
- packaging unique (images Docker)
- tous rangés dans un registre unique 
- Pipeline CD unifié (déploiement avec Helm)
- 1 seule plateforme pour toutes nos applications

</v-clicks>

<div class="mt-5 bg-green-30 dark:bg-green-500 p-3 rounded-lg" v-click>
    <h4 class="text-sm font-bold mb-2">Gains ?</h4>
    <ul class="text-sm">
        <li>Baisse des coûts d'infra (mutualisation)</li>
        <li>Moins de maintenance (du moins, sur papier!)</li>
    </ul>
</div>

<!--
Notes du présentateur: Expliquer pourquoi les applications legacy Windows sont problématiques dans un environnement cloud moderne.
-->


---
layout: image-right
image: /resources/aks_workshop_with_microsoft.png
---

# Mise en oeuvre du projet pilote

Accompagné par Microsoft nous avons :

<v-clicks>

- testé la conteneurisation d'une application legacy Windows en local

- créé un cluster AKS avec support Windows

- déployé notre application legacy Windows dans AKS

- exposé l'application via Application Gateway avec AGIC

- testé la montée en charge des applications

- puis mis à l'échelle !
</v-clicks>

---
layout: two-cols
---

# Qu'est-ce qu'un Windows Container?

<v-clicks>

- Isoler des applications Windows dans des conteneurs
- Mêmes principes que les conteneurs Linux
- Partage le noyau Windows de l'hôte
- Support inclus dans Docker Desktop

</v-clicks>

::right::

  <img v-click="[5,6]"  src="/resources/docker_desktop_windowscontainers.png" class="h-60 absolute left-110 bottom-40" />

  <div v-click="6" class="flex flex-col items-center">
    <div class="flex gap-5 mb-5">
      <carbon-container-registry class="text-5xl" />
      <!-- <carbon-logo-microsoft class="text-5xl" /> -->
    </div>

````md magic-move
```dockerfile {all|1-2|4-6|8}{at:6}
# Exemple de Dockerfile Windows
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

WORKDIR /inetpub/wwwroot

COPY ./website/ .

EXPOSE 80
```
```dockerfile {all|1|3-5|7-8|10|12-13|all}{at:6}
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8.1 AS builder

WORKDIR C:/Temp
COPY . .
COPY ./Config/* ./LegacyApp/ 

WORKDIR C:/Temp/LegacyApp
RUN msbuild.exe

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8.1 AS final

COPY --from=builder "C:\\Temp\\LegacyApp\\" /inetpub/wwwroot/ 
COPY ./Config/web.config /inetpub/wwwroot/web.config

EXPOSE 80
```
````

  </div>

<!--
Références : 
https://learn.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/container-base-images
-->

---
layout: two-cols
---

# Déploiement sur AKS

<v-clicks>

- Configuration du cluster AKS
- Options de réseau (Azure CNI obligatoire)
- Storage classes Windows compatibles
- Gestion des licences Windows

</v-clicks>

<div class="mt-5">
  <v-click>

```bash
# Création d'un cluster AKS avec node pool Windows
az aks create \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --node-count 1 \
    --enable-addons monitoring \
    --generate-ssh-keys

# Ajouter un node pool Windows
az aks nodepool add \
    --resource-group myResourceGroup \
    --cluster-name myAKSCluster \
    --os-type Windows \
    --name winpool \
    --node-count 1
```

  </v-click>
</div>

::right::

<div class="pl-10 pt-10">
  <v-click>

<img src="/resources/hybride_aks_cluster.png" class="h-60" />

  </v-click>

  <div class="mt-10">
    <v-click>
      <div class="bg-blue-50 dark:bg-blue-900 p-3 rounded-lg">
        <h4 class="text-sm font-bold mb-2">Points d'attention</h4>
        <ul class="text-sm">
          <li>Version Windows Server de l'image = version du node</li>
          <li>Limitations des fonctionnalités réseau</li>
          <li>Taille des images (10GB+ parfois)</li>
        </ul>
      </div>
    </v-click>
  </div>
</div>

<!--
doc: https://learn.microsoft.com/en-us/azure/aks/learn/quick-windows-container-deploy-cli?tabs=add-windows-node-pool

Limitations réseaux : 

En AKS hybride, faites simple : Ingress sur Linux, workloads .NET Framework sur Windows, Azure CNI obligatoire pour Windows, pas de Cilium côté Windows aujourd’hui.

Les NetworkPolicies fonctionnent pour Windows via Azure NPM/Calico, mais gardez en tête des lacunes de correspondance/capacités par rapport à Linux.
-->

---
background: './resources/bdxio-kit-communication/illustrations/bridge-black.png'
layout: two-cols
---

# Kubernetes multi-OS

<v-clicks>

- Kubernetes 1.14+ supporte les nœuds Windows
- Scheduling basé sur nodeSelector ou nodeAffinity
- Pod assignation basée sur les contraintes OS
- Networking multi-OS (CNI)
- Un control plane Linux obligatoire

</v-clicks>

::right::

<div class="mt-5">
  <v-click>

```yaml {all|6-7}
apiVersion: v1
kind: Pod
metadata:
  name: windows-iis-pod
spec:
  nodeSelector:
    kubernetes.io/os: windows
  containers:
  - name: iis
    image: mcr.microsoft.com/windows/servercore/iis:latest
    ports:
    - containerPort: 80
```

  </v-click>
</div>

<!--
Notes du présentateur: Expliquer comment Kubernetes gère différentes plateformes d'OS dans un même cluster.
-->

---

# Intégration CI/CD avec Helm

<div class="grid grid-cols-2 gap-3">

<div v-click class="mr-5">

### Manifestes Kubernetes

```yaml {all|15-16}{at:2}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: legacy-windows-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: legacy-windows-app
  template:
    metadata:
      labels:
        app: legacy-windows-app
    spec:
      nodeSelector:
        kubernetes.io/os: windows
      containers:
      - name: legacy-app
        image: myregistry.azurecr.io/legacy-app:1.0
        ports:
        - containerPort: 80
```

</div>

<div>
<div v-click="3" class="mr-5">

### Pipeline CI/CD

```yaml
# Azure DevOps / GitHub Actions
steps:
- uses: actions/checkout@v3

- name: Build Windows container
  run: |
    docker build -t myregistry.azurecr.io/legacy-app:${{ github.sha }} .
    docker push myregistry.azurecr.io/legacy-app:${{ github.sha }}

- name: Deploy to AKS with Helm
  run: |
    helm upgrade --install legacy-app ./charts/legacy-app \
      --set image.tag=${{ github.sha }} \
      --namespace production
```

</div>

<div v-click="4" class="mr-5">

### Chart Helm 

```yaml
# values.yaml
replicaCount: 2
image:
  repository: myregistry.azurecr.io/legacy-app
  tag: latest
resources:
  limits:
    cpu: 1
    memory: 2Gi
```
</div>
</div>
</div>

<img src="/resources/bdxio-kit-communication/illustrations/sheet-black.png" class="absolute right-5 bottom-5" />


<!--
Notes du présentateur: Intégration dans une chaîne CI/CD avec des outils modernes, spécificités de Windows.
-->

---
layout: two-cols
---

# Bénéfices

<v-clicks>

- Uniformisation de l'infrastructure
- Optimisation des coûts (FinOps)
- Intégration aux pratiques DevOps modernes
- Observabilité améliorée
- Scalabilité et haute disponibilité
- Transition progressive vers le cloud natif

</v-clicks>

<div v-click class="mt-20">
  <img src="/resources/bdxio-kit-communication/illustrations/left-top-angle-black.png" class="w-10 absolute left-5 bottom-40" />
  <blockquote class="text-sm italic">
    "Grâce à cette approche, nous avons réduit nos coûts d'infrastructure de 30% tout en améliorant la résilience de nos applications Windows legacy."
  </blockquote>
</div>

::right::

# Limitations

<v-clicks>

- Taille des images (10GB+)
- Compatibilité des versions Windows
- Performance de démarrage
- Besoin de licences Windows
- Limitations du networking
- Gestion des mises à jour Windows

</v-clicks>

<!--
https://learn.microsoft.com/en-us/azure/aks/windows-best-practices
https://learn.microsoft.com/en-us/azure/aks/upgrade-windows-os
-->

<!--
Notes du présentateur: Résumé des avantages et limitations de l'approche, retours d'expérience.
-->

---
layout: center
class: text-center
background: './resources/bdxio-kit-communication/illustrations/bridge-background-blue-large.png'
---

# Conclusion

<div class="text-2xl mb-10" v-click>
  Modernisez vos applications Windows sans les réécrire
</div>

<div class="grid grid-cols-3 gap-5" v-click>
  <div class="bg-white/10 backdrop-blur-sm p-5 rounded-lg">
    <carbon-container-software class="text-4xl mb-3" />
    <h3>Conteneurisation</h3>
    <p class="text-sm">Empaquetez vos apps Windows dans des conteneurs</p>
  </div>
  
  <div class="bg-white/10 backdrop-blur-sm p-5 rounded-lg">
    <carbon-kubernetes class="text-4xl mb-3" />
    <h3>Orchestration</h3>
    <p class="text-sm">Gérez-les avec les mêmes outils que vos workloads Linux</p>
  </div>
  
  <div class="bg-white/10 backdrop-blur-sm p-5 rounded-lg">
    <carbon-cloud-service-management class="text-4xl mb-3" />
    <h3>Évolution</h3>
    <p class="text-sm">Préparez la transition vers des architectures cloud natives</p>
  </div>
</div>

<div class="mt-10" v-click>
  <img src="/resources/bdxio-kit-communication/logo/logo-blanc.png" class="h-10 inline-block" />
  <p class="text-lg mt-2">Merci pour votre attention!</p>
</div>

<!--
Notes du présentateur: Conclusion et message principal à retenir.
-->

---
layout: center
class: text-center
---

# Questions & Réponses

<div class="flex justify-center items-center">
  <carbon-help class="text-6xl" />
</div>

<div class="mt-10">
  <img src="/resources/bdxio-kit-communication/illustrations/right-bottom-angle-black.png" class="w-20 absolute right-10 bottom-10" />
  <img src="/resources/bdxio-kit-communication/illustrations/left-top-angle-black.png" class="w-20 absolute left-10 top-10" />
</div>

<!--
Notes du présentateur: Préparer quelques réponses aux questions fréquentes.
-->
