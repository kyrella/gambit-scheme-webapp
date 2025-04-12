import * as esbuild from "esbuild"

const isDev = () => process.env.NODE_ENV !== "production"

const config = {
  entryPoints: ["js/index.js"],
  bundle: true,
  outfile: "build/index.js",
  minify: !isDev(),
  loader: {
    ".svg": "dataurl",
  },
  logLevel: "info",
  platform: "browser",
  define: {
    // gambit tries to do runtime detection
    "_os_nodejs": "null"
  }
}

const ctx = await esbuild.context(config)

if (isDev()) {
  await ctx.watch()
  await ctx.serve({
    servedir: "build",
    host: "127.0.0.1",
    port: 8080,
  })
} else {
  await ctx.build()
}
