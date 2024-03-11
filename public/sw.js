const version = '3'; // Updated version number
const cacheName = `cache-${version}`;

const urlsToCache = [
    './',
    './css/css_compressed.php',    
    './css/scss.css',
    './css/style.css',
    './css/xml.css',
    './js/jquery.js',
    './js/data.json',
    './js/jquery.min.js',
    './css/fonts/fa-brands.ttf',
    './css/fonts/fa-brands.woff2',
    './css/fonts/fa-solid.ttf',
    './css/fonts/fa-solid.woff2',
    './img/siteLogo.png',
    './uploads/siteBanner.jpg',
    './img/bee.png',
    './img/empty.png',
    './img/favicon.png',
];

self.addEventListener('install', (event) => {
    event.waitUntil(
        caches.open(cacheName).then((cache) => {
            return cache.addAll(urlsToCache);
        })
    );
});

self.addEventListener('activate', (event) => {
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.filter((name) => {
                    return name.startsWith('cache-') && name !== cacheName;
                }).map((cacheName) => {
                    return caches.delete(cacheName);
                })
            );
        })
    );
});

self.addEventListener('fetch', (event) => {
    event.respondWith(
        caches.match(event.request).then((response) => {
            if (response) {
                return response;
            }
            return fetch(event.request).then((response) => {
                if (!response || response.status !== 200 || response.type !== 'basic') {
                    return response;
                }
                const responseToCache = response.clone();
                caches.open(cacheName).then((cache) => {
                    cache.put(event.request, responseToCache);
                });
                return response;
            });
        })
    );
});

self.addEventListener('message', (event) => {
    if (event.data === 'SKIP_WAITING') {
        self.skipWaiting();
    }
});
