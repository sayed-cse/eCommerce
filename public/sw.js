const version = '2';
const caching_assets = [
    '/',
    'css/scss.css',
    'js/jquery.js',
    'css/fonts/fa-brand.ttf',
    'css/fonts/fa-brand.woff2',
    'css/fonts/fa-solid.ttf',
    'css/fonts/fa-solid.woff2',
    'img/baselogo.webp',
    'uploads/1.webp'
]
self.addEventListener('install', (event) => {
  event.waitUntil(
    (async() => {
        try {
            const cache_obj = await caches.open(version);
            cache_obj.addAll(caching_assets);
            const skip = self.skipWaiting();
        }
        catch{
            console.log("error occured while caching...")
        }
    })()
    )
});
//
self.addEventListener('activate', (event) => {
    // removing the old cache.
    event.waitUntil(
        (async () => {
            const cache_keys = await caches.keys()
            //console.log(cache_keys)
            cache_keys.forEach(
                key => {
                    if (key !== version) {
                        console.log("Service Worker deleted old cache!")
                        return caches.delete(key)
                    }
                }
            )
            return Promise.all(cache_keys)
        })()
    )
});
//
self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches
      .match(event.request)
      .then((response) => response || fetch(event.request)),
  );
});
