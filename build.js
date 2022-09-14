const vuePlugin = require("esbuild-plugin-vue3")

// esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=assets

require('esbuild').build({
    entryPoints: ['app/javascript/application.js'],
    bundle: true,
    outdir: 'app/assets/builds',
    plugins: [vuePlugin()],
    publicPath: 'assets',
    watch: true
});
