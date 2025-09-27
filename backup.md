---
theme: seriph
background: './resources/bdxio-kit-communication/illustrations/bridge-background-blue-large.png'
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

<div class="abs-br m-6 flex gap-2">
  <a href="https://bdxio.fr" target="_blank" alt="BDX.IO Website">
    <img src="/resources/bdxio-kit-communication/logo/logo-blanc.png" class="h-8">
  </a>
  <a href="https://github.com/nicolas-boisseau" target="_blank" alt="GitHub Profile" class="text-xl icon-btn opacity-50 !border-none !hover:text-white">
    <carbon-logo-github />
  </a>
</div>

<!--
Notes du présentateur: Introduction personnelle et remerciement à BDX.IO
-->

---
layout: two-cols-header
---

# Un peu de contexte

::left::

<div class="m-4">

  ## Points clefs

  <v-clicks>

  - **Un produit** : Plateforme de paiement SaaS

  - **Un besoin** : environnement Sandbox public

  - Décision d'utiliser le Cloud Azure

  </v-clicks>

</div>

::right:: 

<div class="m-4" v-click>

  ## Un environnement hybride

<img class="mt-5 mb-20" src="/resources/ecosystem.png" />

</div>

<img src="/resources/bdxio-kit-communication/illustrations/scribble-yellow.png" class="h-10 absolute left-10 bottom-20" />

---

# Qu'est-ce qu'on fait pour le legacy Windows ?

<img src="/resources/legacy.png" class="h-80 absolute left-10 bottom-30" />

<div class="grid grid-cols-3 gap-3 grid-rows-2 mt-10 ml-60" >

 <div class="col-span-2" v-click="1">

   #### Azure App Services Windows (managed PaaS)
    
   <ul class="text-4 mt-1 ml-4">
      <li>Support natif des applications Windows (IIS-like)</li>
      <li>Besoin de packaging spécifique (.zip)</li>
      <li>Ecosystème spécifique (slots, plans, etc.), logs, etc.</li>
   </ul>

  </div>

  <div class="w-30 absolute right-20" v-click="1">
```mermaid
architecture-beta
    service appService(azure:app-services)[App Services]
```
  </div>

  <div class="col-span-2" v-click="2">

   #### Serveurs virtuels (VM, IaaS)

  <ul class="text-4 mt-1 ml-4">
    <li>Utiliser des VM Windows Server </li>
    <li>Avantages : iso on-premise, pas de changement d'architecture</li>
    <li>Inconvénients : coût, maintenance, Cloud non natif</li>
   </ul>
  </div>
  <div class="w-30 absolute right-20 bottom-30" v-click="2">
```mermaid
architecture-beta
    service appService(azure:virtual-machine)[VM Windows Server]
```
  </div>
</div>

<img src="/resources/bdxio-kit-communication/illustrations/scribble-turquoise.png" class="h-10 absolute right-10 bottom-10" />

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
    <template #2>
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
    <div class="mb-15 mt-5">
      <ul v-click="1">
          <li>Backend legacy Windows-only (.NET Framework, IIS)</li>
          <li>Exposition via Application Gateway dédié car non supporté par AGIC</li>
        </ul>
    </div>
    <div>
      <ul v-click="2">
        <li>Backend moderne (.NET Core, Node.js, etc.) sur AKS</li>
        <li>Exposition Application Gateway Ingress Controller (AGIC)</li>
      </ul>
    </div>
  </div>
</div>

<img src="/resources/bdxio-kit-communication/illustrations/scribble-yellow.png" class="h-10 absolute left-10 bottom-20" />

<!--
Notes du présentateur: Agenda de la présentation
-->

---
layout: image-left
image: /resources/double_hosting_legacy_and_modern.png
---

# Ca va pas ?

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
      Maintenance globale 
      <span v-mark="{ at: 1, color: 'red', type: 'circle' }">
        <strong class="text-xl">x2</strong>
      </span>
      <br/>
      (infra, packaging, pipelines, monitoring, etc.)
    </td>
  </tr>
  </tbody>
  
</table>

<!-- <div>
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

</div> -->

---

# Pendant ce temps...

<div>
```mermaid
timeline
    2015 : Introduction Windows Server Containers (Docker + Windows Server 2016 TP)
    2019-03 : Kubernetes v1.14 - GA des nœuds Windows
    2020-05 : AKS - GA du support Windows Server nodes
```
</div>

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
- Deux types:
  - Windows Server Core (complet)
  - Windows Nano Server (minimal)
- Mêmes principes que les conteneurs Linux
- Partage le noyau Windows de l'hôte
- Support inclus dans Docker Desktop

</v-clicks>

<img src="/resources/bdxio-kit-communication/illustrations/circle-orange.png" class="w-20 absolute left-10 bottom-10" />

::right::

  <img v-click="[5,6]"  src="/resources/docker_desktop_windowscontainers.png" class="h-60 absolute left-110 bottom-40" />

  <div v-click="6" class="flex flex-col items-center">
    <div class="flex gap-5 mb-5">
      <carbon-container-registry class="text-5xl" />
      <!-- <carbon-logo-microsoft class="text-5xl" /> -->
    </div>

````md magic-move
```dockerfile {all|1-2|4-6|8} {at:5}
# Exemple de Dockerfile Windows
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

WORKDIR /inetpub/wwwroot

COPY ./website/ .

EXPOSE 80
```
```dockerfile {all|1|3-5|7-8|10|12-13|all} {at:5}
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
Notes du présentateur: Introduction aux concepts des Windows Containers et différences avec Linux.
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
layout: full
---

test

---

# Intégration CI/CD avec Helm

<div class="grid grid-cols-2 gap-5">
  <div>
    <v-click>
      <h3 class="mb-3">Manifestes Kubernetes</h3>
      ```yaml
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
    </v-click>
  </div>
  
  <div>
    <v-click>
      <h3 class="mb-3">Pipeline CI/CD</h3>
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
</v-click>
  </div>
</div>

<div v-click class="mt-5">
  <h3 class="mb-3">Chart Helm</h3>
  <div class="flex">
    <div class="flex-1">
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
    <div class="flex-1">
      <img src="/resources/bdxio-kit-communication/illustrations/sheet-black.png" class="w-40 mt-5 ml-10" />
    </div>
  </div>
</div>

<!--
Notes du présentateur: Intégration dans une chaîne CI/CD avec des outils modernes, spécificités de Windows.
-->

---
layout: two-cols
---

# Bénéfices

<img src="/resources/bdxio-kit-communication/illustrations/right-bottom-angle-purple.png" class="w-20 absolute right-5 top-10" />

<v-clicks>

- Uniformisation de l'infrastructure
- Optimisation des coûts (FinOps)
- Intégration aux pratiques DevOps modernes
- Observabilité améliorée
- Scalabilité et haute disponibilité
- Transition progressive vers le cloud natif

</v-clicks>

<div v-click class="mt-5">
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
- Certains composants COM+ complexes
- Besoin de licences Windows
- Limitations du networking
- Gestion des mises à jour Windows

</v-clicks>

<div v-click>
  <img src="/resources/bdxio-kit-communication/illustrations/scribble-turquoise.png" class="h-8 absolute right-20 bottom-20" />
</div>

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
    <h3>Containerisation</h3>
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

<div class="abs-br m-6 flex gap-2">
  <a href="https://bdxio.fr" target="_blank" alt="BDX.IO Website">
    <img src="/resources/bdxio-kit-communication/logo/logo-blanc.png" class="h-8">
  </a>
  <a href="https://github.com/nicolas-boisseau" target="_blank" alt="GitHub Profile" class="text-xl icon-btn opacity-50 !border-none !hover:text-white">
    <carbon-logo-github />
  </a>
</div>

<!--
Notes du présentateur: Préparer quelques réponses aux questions fréquentes.
-->
