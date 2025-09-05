
# Oui, Kubernetes peut faire tourner vos applis Windows. Sérieusement.

## Pitch

Et si vous pouviez vraiment TOUT mettre dans Kubernetes — même vos vieilles applis Windows/IIS ?
Ce talk explore comment containeriser des applications legacy Windows et les exécuter efficacement sur Kubernetes. Une opportunité de moderniser sans tout réécrire, tout en tirant profit de l’écosystème Kube (Helm, CI/CD, scalabilité, etc.). Oui, c’est possible, et on vous montre comment !

## Résumé détaillé

Beaucoup d'entreprises traînent encore des applications historiques Windows (IIS, .NET Framework 4.x, COM+, etc.). Ces apps sont souvent hors des process DevOps modernes, mal isolées, et monopolisent des VMs spécifiques coûteuses à maintenir.

Et si on les faisait migrer... dans Kubernetes ? Grâce au support de Windows Containers et au scheduling multi-OS de Kubernetes, il est aujourd’hui possible d’orchestrer aussi bien des workloads Linux que Windows. Ce talk démystifie cette approche.

### Objectifs du talk
Montrer concrètement comment containeriser une appli Windows legacy.
Déployer et orchestrer ce container dans un cluster AKS (Azure Kubernetes Service).
Intégrer dans une chaîne CI/CD avec Helm, Docker registry, etc.
Identifier les limites (licences, perf, limitations Windows ServerCore vs Nano, etc.).
Montrer les bénéfices : scalabilité, homogénéité des déploiements, meilleure observabilité.

### Public visé
Développeurs, SREs, DevOps et architectes qui ont un pied dans le passé (les applis legacy) et l’autre dans le cloud natif.
