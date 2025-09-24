# L'environnement hybride traditionnel

<div class="flex justify-center">
  <div class="mermaid w-full">
```mermaid
flowchart TB
subgraph Azure
    subgraph "VMs Windows"
    monolith[".NET Framework 4.x<br/>IIS<br/>Services Windows"]
    end
    subgraph "Services App/Containers"
    micro[".NET Core<br/>Microservices<br/>Containers Linux"]
    end
end
devops1[Équipe DevOps Windows] --> monolith
devops2[Équipe DevOps Linux] --> micro
style monolith fill:#f9f,stroke:#333,stroke-width:2px
style micro fill:#bbf,stroke:#333,stroke-width:2px
```
  </div>
</div>

<v-clicks>

- Équipes et compétences séparées
- Coûts d'infrastructure doublés
- Cycles de déploiement différents
- Problèmes d'intégration entre les systèmes

</v-clicks>

<img src="/resources/bdxio-kit-communication/illustrations/scribble-turquoise.png" class="h-10 absolute right-10 bottom-20" />

<!--
Notes du présentateur: Montrer les silos et la duplication des efforts dans un environnement hybride.
-->
