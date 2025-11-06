# Welcome to [Slidev](https://github.com/slidevjs/slidev)!

To start the slide show:

- `pnpm install`
- `pnpm dev`
- visit <http://localhost:3030>

Edit the [slides.md](./slides.md) to see the changes.

Learn more about Slidev at the [documentation](https://sli.dev/).


# Resources

Icones :
- [Carbon icons](https://carbon-elements.netlify.app/icons/examples/preview/)
- [Logos icons](https://icon-sets.iconify.design/logos/)
- [Microsoft Azure icons](https://learn.microsoft.com/en-us/azure/architecture/icons/)
- [Azure iconify Icons](https://github.com/NakayamaKento/AzureIcons)

Archi cloud avec mermaid:
- https://github.com/mermaid-js/mermaid/issues/6109

Documentation autour des Windows Containers :
- [Setup Windowscontainers](https://learn.microsoft.com/fr-fr/virtualization/windowscontainers/quick-start/set-up-environment?tabs=dockerce)
- [Windows Containers overview](https://learn.microsoft.com/en-us/virtualization/windowscontainers/)
- [Windows vs Linux containers](https://learn.microsoft.com/en-us/azure/aks/windows-vs-linux-containers)
- [Windows containers images](https://learn.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/container-base-images)
- [.NET Framework docker images](https://mcr.microsoft.com/en-us/artifact/mar/dotnet/framework/aspnet/tags)

Ressources additionnelles autour des Windows Containers :
- [LogMonitor pour le forward des logs sur stdout/err](https://github.com/microsoft/windows-container-tools/blob/main/LogMonitor/README.md)

Sur Windows 11 Pro (non dispo sur W11 Famille)
```powershell
Enable-WindowsOptionalFeature -Online -FeatureName $("Microsoft-Hyper-V", "Containers") -All
```










unocss : https://unocss.dev/interactive/

LogMonitor : https://github.com/microsoft/windows-container-tools/blob/main/LogMonitor/README.md