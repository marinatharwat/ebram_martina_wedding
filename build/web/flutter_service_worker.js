'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "22f9ce93dc9fa4e2aea7e1360964c3b8",
"assets/AssetManifest.bin.json": "5f3521b0ccd787367be3631376834794",
"assets/assets/audio/special_message.mp3": "236b07f1c800cf09f554ad83ae52f7bd",
"assets/assets/fonts/AlexBrush-Regular.ttf": "f6af62cf0553ca7ae4b5226044e805ce",
"assets/assets/fonts/CormorantGaramond-Italic.ttf": "b93e759c0724aeddd49f2d28529b8936",
"assets/assets/fonts/CormorantGaramond-Medium.ttf": "4baf47b7164e17ba33909f7cd05d882c",
"assets/assets/fonts/CormorantGaramond-SemiBold.ttf": "9374c4c87192924af57d40bd8c61af71",
"assets/assets/fonts/GreatVibes-Regular.ttf": "36d143e67eaeffde4a1b8d9535bce094",
"assets/assets/fonts/Jost-Medium.ttf": "faf43540e8e0383a20bf6930f6190114",
"assets/assets/fonts/Parisienne-Regular.ttf": "191e681b52e5ee7642d3a9828d5c316a",
"assets/assets/fonts/PlayfairDisplay-Bold.ttf": "038aec929d8d05c5de0bb20e040f9973",
"assets/assets/fonts/PlayfairDisplay-Italic.ttf": "a94bf8e2798ad379919855c03694568d",
"assets/assets/fonts/PlayfairDisplay-Regular.ttf": "038aec929d8d05c5de0bb20e040f9973",
"assets/assets/images/1.jpeg": "cc2b0b1abba02ff96b3947e68c9534fa",
"assets/assets/images/1.png": "4e83b8a44df0466f20975b6f51f44ae8",
"assets/assets/images/10.jpeg": "bc7e4ecf182b3df6a2e7709567532c01",
"assets/assets/images/2.png": "22a2a77d0090f103a4639cd7974a8667",
"assets/assets/images/3.jpeg": "3a995c10a096138ae4574aa448f9f39d",
"assets/assets/images/4.jpeg": "bf8e67eb6b2c6d04dfea59d60b7bb674",
"assets/assets/images/5.jpeg": "cebdbb061e179cb7180342f723c316f6",
"assets/assets/images/6.jpeg": "e59b7e8df91468d51d3f932ef0a037ef",
"assets/assets/images/7.jpeg": "970449c07a42c8b5c00c0e20f54e07e4",
"assets/assets/images/8.png": "b688298c8c0e61f17d52af550c2b5391",
"assets/assets/images/b.png": "1a20745236535e00bcf7eefda53e9f83",
"assets/assets/images/curch.png": "f6b7676885e54996c81ae45f5a9e26f0",
"assets/assets/images/leaf.png": "40148ea3d5d9f32fe1467faa3255b6bb",
"assets/assets/images/message.jpeg": "f0b6a6607979e7d4ad7ab2f0b815a2dd",
"assets/assets/images/plant.png": "d320446eb627011eea0a8b8eebd04115",
"assets/assets/images/wedding_rings.png": "4fed78a79f5adac73b62f95cc1336de0",
"assets/FontManifest.json": "d8e4e68d6fa51c1c04f8352e194995d9",
"assets/fonts/MaterialIcons-Regular.otf": "1988c42d44a2257dc682fbcd0618b901",
"assets/NOTICES": "c5c61df9aaa2b0513426cad96ddf35d6",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "1a0c2278f73cbdb41ea77d7639791f2d",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "5d7d8bffe0468c03dbf3520017bf4a7c",
"/": "5d7d8bffe0468c03dbf3520017bf4a7c",
"logo.png": "d04c61524d9d5fcccc7b443df7bffee2",
"main.dart.js": "b70c786bf6797777686a048d4417f0be",
"manifest.json": "bfed612aeb81bd5706aa58d3f011f341",
"version.json": "28d37950864015870bc40d56e70a4b93"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
