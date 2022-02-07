'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/assets/icon_facebook.png": "804cf2a905b2c7460adcaadb3dbfe9ae",
"assets/assets/prueba.jpg": "07b405dbf42fbad21f4255a804c59cef",
"assets/assets/icon_google.png": "28b51fa69f1f0cb8a8f7a4bdd8e173c9",
"assets/assets/logo.png": "7ae9268be56ac553cc479ece48e05991",
"assets/assets/icons/home.svg": "40b87d8cd311c1a75eb4865ed87dc8e0",
"assets/assets/icons/search.svg": "119cb00d694da2af81c8e0220bbec50e",
"assets/assets/icons/plus.svg": "9f23e64f9fa51f359e84705da3ca2675",
"assets/assets/icons/events.svg": "bb3cf75b982cee9c3b293a983e46d0a2",
"assets/assets/icons/user.svg": "1acd64a4893d4eced9cdf04226e8f283",
"assets/assets/icon.png": "8ac50d54716ef12d71db52324f32ba13",
"assets/assets/fonts/abel/Abel-Regular.ttf": "1052d6ca3993ae24a932304560a4c8b4",
"assets/assets/fonts/biryani/Biryani-Light.ttf": "87d2a4fd61b107f3e424fe7ba64c2353",
"assets/assets/fonts/biryani/Biryani-ExtraLight.ttf": "967c3d6894a91bbed4c15a0243c0b2bc",
"assets/assets/fonts/biryani/Biryani-ExtraBold.ttf": "fb091ddf6ec3159b26e53d57b54378a7",
"assets/assets/fonts/biryani/Biryani-Bold.ttf": "7c32b0eca9e76ba41a4088d251088e1e",
"assets/assets/fonts/biryani/Biryani-SemiBold.ttf": "ac266aa76a0a86d25e7e233942b76481",
"assets/assets/fonts/biryani/Biryani-Regular.ttf": "eb0445cf4c23226181df62694d47a8e7",
"assets/assets/fonts/biryani/Biryani-Black.ttf": "dd9bc6bb132a640b5854b80776094b86",
"assets/assets/ojos.png": "c9dd7c3932e6a44840e73906dcef02dd",
"assets/assets/guateGeeksLogo.png": "c50ee6617a91e4c9527da1a055cfddbd",
"assets/assets/icon_question.png": "f113f43571c39cb02a19246fb1663113",
"assets/assets/icon_email.png": "37f207403ee19ea3f7b9e72200462eac",
"assets/FontManifest.json": "26be0fe0a0291aab5d0be165f0db29ad",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/AssetManifest.json": "42b37efa33069ed81e707d7f5693516b",
"assets/NOTICES": "b80852edf30e021cec64cc3df1e65425",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"firebase-config.js": "01ebaf1b69d2a21a35fc2537dfa5deaf",
"index.html": "f6b47166162def2226e298ca9b9dc78b",
"/": "f6b47166162def2226e298ca9b9dc78b",
"version.json": "da2e0573834eb2187048bf7b88f15c46",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"main.dart.js": "36edb753cd1715d04a19c47c8231ae19",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"manifest.json": "cd30b6ab6774127656ea9c126369b699"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
