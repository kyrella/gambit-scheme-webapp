new EventSource("/esbuild").addEventListener("change", () => { location.reload() })

import * as maquette from "maquette"
import "./gen/app"

window.maquette = maquette
window.h = (tag, alist, nodes) => {
    const props = alist.length > 0 ? Object.fromEntries(alist) : {}
    const children =
        nodes instanceof Array ? nodes :
        typeof nodes === "string" ? [nodes] :
        undefined
    return maquette.h(tag, props, children)
}

