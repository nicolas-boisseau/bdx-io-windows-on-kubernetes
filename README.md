# Slides BDXIO : "Oui, Kubernetes peut faire tourner vos applis Windows. Sérieusement."

## Description

Présentation de 15 minutes pour la conférence BDXIO (Novembre 2025) sur la containerisation et l'orchestration d'applications legacy Windows avec Kubernetes.

## Structure de la présentation

1. **Introduction** (1 min) - Slide titre accrocheur
2. **Le problème** (2 min) - Applications Windows legacy
3. **La solution** (1 min) - Kubernetes + Windows Containers
4. **Demo** (6 min) - Containerisation et déploiement AKS
   - Étape 1 : Dockerfile Windows (3 min)
   - Étape 2 : Déploiement Kubernetes (3 min)
5. **Architecture** (2 min) - Vue d'ensemble multi-OS
6. **Bénéfices** (2 min) - Avant/Après
7. **Limitations** (1 min) - Points d'attention
8. **Conclusion** (1 min) - Message final et appel à l'action

**Total : 15 minutes** + temps pour questions

## Fichiers

- `slides.adoc` - Fichier source AsciiDoc des slides
- `bdxio-theme.css` - Thème CSS personnalisé BDXIO
- `bdxio-kit-communication/` - Assets graphiques BDXIO

## Prérequis pour générer les slides

### Installation d'Asciidoctor et reveal.js

```bash
npm init -y
npm i --save asciidoctor @asciidoctor/reveal.js
npx asciidoctor-revealjs --version
```

### Génération des slides

```bash
npx asciidoctor-revealjs .\slides.adoc
```

Cela génère un fichier `slides.html` que vous pouvez ouvrir dans un navigateur web.

## Utilisation lors de la présentation

### Navigation
- **Flèches** : Navigation entre slides
- **Espace** : Slide suivante
- **Esc** : Vue d'ensemble des slides
- **S** : Notes du présentateur (speaker notes)
- **F** : Mode plein écran

### Notes du présentateur
Appuyez sur **S** pour ouvrir les notes du présentateur dans une nouvelle fenêtre. Chaque slide contient des notes avec :
- Le timing prévu
- Les points clés à mentionner
- Le contexte pour les transitions

### Mode présentation
1. Ouvrir `slides.html` dans le navigateur
2. Appuyer sur **F** pour le mode plein écran
3. Appuyer sur **S** pour les notes du présentateur
4. Utiliser les flèches ou la barre d'espace pour naviguer

## Personnalisation

### Modifier le contenu
Éditez le fichier `slides.adoc` avec la syntaxe AsciiDoc :
- `==` pour un nouveau slide
- `[%step]` pour l'apparition progressive des éléments
- `[.fragment.highlight-blue]` pour mettre en évidence
- `[.notes]` pour ajouter des notes du présentateur

### Modifier le style
Le fichier `bdxio-theme.css` contient les couleurs et styles BDXIO :
- Couleurs principales définies dans `:root`
- Styles pour les titres, listes, code, etc.
- Design responsive

### Assets graphiques
Les illustrations du kit BDXIO sont référencées avec :
```asciidoc
image::bdxio-kit-communication/illustrations/nom-illustration.png[Alt text, width, height, align="center"]
```

## Tips pour la présentation

1. **Timing** : Respecter les 15 minutes en suivant les notes
2. **Demo** : Préparer les exemples de code à l'avance
3. **Questions** : Prévoir 2-3 minutes en fin si possible
4. **Backup** : Avoir une version PDF au cas où (export depuis le navigateur)

## Ressources supplémentaires

- [Documentation AsciiDoc](https://asciidoc.org/)
- [Asciidoctor reveal.js](https://asciidoctor.org/docs/asciidoctor-revealjs/)
- [Kit de communication BDXIO](https://github.com/bdxio/bdxio-kit-communication)

---

**Bon courage pour ta présentation BDXIO ! 🚀**
