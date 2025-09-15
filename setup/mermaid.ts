import { defineMermaidSetup } from '@slidev/types'

// ⚠️ utiliser le même import Mermaid que Slidev :
import mermaid from 'mermaid/dist/mermaid.esm.mjs'

// Choisis les packs d'icônes dont tu as besoin
import { icons, icons as logos } from '@iconify-json/logos'
import { icons as carbon } from '@iconify-json/carbon'

mermaid.registerIconPacks([
  { name: logos.prefix, icons: logos },      // "logos"
  { name: carbon.prefix, icons: carbon },      // "carbon"
  { name: "azure", loader: () => fetch("/AzureIcons/icons.json").then(r => r.json()) } // prefix: azure
])

export default defineMermaidSetup(() => {
  return {
    theme: 'forest',
  }
})