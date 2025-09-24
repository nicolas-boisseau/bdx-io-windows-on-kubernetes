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
