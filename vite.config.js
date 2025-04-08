import {
    defineConfig
} from 'vite';
import laravel from 'laravel-vite-plugin';
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/style.css','resources/css/style-main.css','resources/css/style-internalProcess.css','resources/js/app.js'],
            //refresh: [`resources/views/**/*`],
            refresh: ['resources/views/**/*', 'resources/css/**/*', 'resources/js/**/*'],
        }),
        tailwindcss(),
    ],
    server: {
        cors: true,
    },
});