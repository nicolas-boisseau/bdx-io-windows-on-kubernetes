import { defineMermaidSetup } from '@slidev/types'

// ⚠️ utiliser le même import Mermaid que Slidev :
import mermaid from 'mermaid/dist/mermaid.esm.mjs'

// Choisis les packs d'icônes dont tu as besoin
import { icons, icons as logos } from '@iconify-json/logos'
import { icons as carbon } from '@iconify-json/carbon'
import { icons as mdi } from '@iconify-json/mdi'

// Enregistre les packs d'icônes

mermaid.registerIconPacks([
  { name: logos.prefix, icons: logos },      // "logos"
  { name: carbon.prefix, icons: carbon },      // "carbon"
  { name: mdi.prefix, icons: mdi },      // "mdi"
  { name: "azure", loader: () => fetch(`${import.meta.env.BASE_URL ?? '/'}AzureIcons/icons.json`).then(r => r.json()) } // prefix: azure
])

export default defineMermaidSetup(() => {
  return {
    theme: 'forest',
  }
})