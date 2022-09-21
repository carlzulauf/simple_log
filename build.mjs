import esbuild from "esbuild"
import vuePlugin from "esbuild-plugin-vue3"
import {sassPlugin} from "esbuild-sass-plugin"

// esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=assets

await esbuild.build({
    entryPoints: ['app/javascript/application.js'],
    bundle: true,
    outfile: 'app/assets/builds/application.js',
    plugins: [vuePlugin()],
    publicPath: 'assets'
})

await esbuild.build({
    entryPoints: ['app/assets/stylesheets/application.bulma.scss'],
    bundle: true,
    outfile: 'app/assets/builds/application-layout.css',
    plugins: [sassPlugin()],
    publicPath: 'assets'
})
