'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "58b041b8be20c939ff4599b970c92998",
"version.json": "d8f60c1825dec6317656dba15108a3be",
"index.html": "b2ee7ed505f73bd629338965a511f90a",
"/": "b2ee7ed505f73bd629338965a511f90a",
"main.dart.js": "2a1b70545aa4970c1f3f7d38d8201583",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "e0f43b5c3bd2c4d3215e51e02a844ae1",
"assets/NOTICES": "5067ca8f9d32390ff4e26796c72bd1d3",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "6ea37699bdf09bf3307f3a2370dfd58f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "fab7d282a69882da55ec0e3705b8ff72",
"assets/fonts/MaterialIcons-Regular.otf": "68e16f2aadc60724b5c8ef8f107642ba",
"assets/assets/Background_Q12.jpg": "b62d1ab493e0d0f541b87c395944680a",
"assets/assets/Background_Q1.jpg": "8b466bf9a9152f372b44211ed4399da8",
"assets/assets/Background_chang%2520noi.jpg": "9fc21ce57e9b401caded2a649e2f800b",
"assets/assets/Background_Q11.jpg": "7fbb83d27189c77bd72b75e6b9e48a6d",
"assets/assets/Background_Q2.jpg": "830d72a3ba20ad73edbfd1c1ebd3978d",
"assets/assets/Train.png": "9cc5d9ec2fbfd7ba00ee5ad814500510",
"assets/assets/Background_Q3.jpg": "91613078f2d220ebd46fceaf31212520",
"assets/assets/Pla%2520kad%2520result%2520sp.jpg": "41210d5731ee88be73ef41e18caeccde",
"assets/assets/Background_Q10.jpg": "f44b6d4132f5506f9d87f52f45312d9c",
"assets/assets/tatn.png": "eebe3e730633bcc50f62827057a6dc44",
"assets/assets/Pla%2520kad%2520result%2520en.jpg": "48aced81d2f620ac924bb4eec17814c8",
"assets/assets/step3.png": "bd20cba22ba9da47afd4a9a1f747b14f",
"assets/assets/Background_Q7.jpg": "e607fafb191c0f1b234667bb0c864cb0",
"assets/assets/Background_Q6.jpg": "846155358a8c70cb8250cc4371765e84",
"assets/assets/step2.png": "5dcbe81fc5271360731ebf567618c80a",
"assets/assets/landscape.png": "40abcbdae7d63db271d160289e2ae16e",
"assets/assets/Background_Q4.jpg": "381a1deeb2506313897784a57370d64b",
"assets/assets/Background_Q5.jpg": "e0a54582c39734a6c2a98dface01e8ef",
"assets/assets/step1.png": "b0ff68f7c4a0054ac65cffb08b73285a",
"assets/assets/Background_Chai.jpg": "1bf9a0ab09038d458b4f9ce37a1571eb",
"assets/assets/Train_loading.png": "c2494f02755049b55450652dd04173cb",
"assets/assets/Mali%2520Result%2520sp.jpg": "b502e41ed684546579a1b3c3ab836002",
"assets/assets/character_profiles/plakad_profile.png": "33f10d561f5eb8bacbf726ebc301ffdb",
"assets/assets/character_profiles/changnoi_profile.png": "cc4192d2162ba04bf9458278ee6876b4",
"assets/assets/character_profiles/chai_profile.png": "64c4fbb5f4cf7399e3c5a856cb5f8c24",
"assets/assets/character_profiles/mali_profile.png": "8ad003c680b56ca8d3861641a7a79760",
"assets/assets/character_profiles/ping_profile.png": "a2560796627040e37facfcfe047d3d93",
"assets/assets/tropy2.png": "e15e0ceb8b5fb09ebe148b7a20b76541",
"assets/assets/logo_tat.png": "8b9caee3b2f9143044de1c35699ecd60",
"assets/assets/Chai%2520Result%2520sp.jpg": "c3caecbebe84665f0a3aee6ad763f14a",
"assets/assets/challenge_asset/background_challenge_changnoi.jpg": "66d6a815f5c30c33f086211fa28934e8",
"assets/assets/challenge_asset/background_challenge_mali.jpg": "0369676331f53509124b20ebc8cb4530",
"assets/assets/challenge_asset/background_challenge_ping.jpg": "7b4c16d76fab7fbee86ff8d290b2e679",
"assets/assets/challenge_asset/icon_award.svg": "c0f97868a69ff5636432753d45bdace9",
"assets/assets/challenge_asset/background_challenge_plakad.jpg": "c02ec6958f72cf9b1195ea5964f2826b",
"assets/assets/challenge_asset/background_challenge_chai.jpg": "2dc46444a39a95294d7006f2e0b0be60",
"assets/assets/Chai%2520Result%2520en.jpg": "f6cdf1eb17c16277a228be0eca26a50f",
"assets/assets/Background_home.jpg": "ac1dc0083e246c65fff8cf49f11c29b1",
"assets/assets/Mali%2520Result%2520en.jpg": "ccdad2f4ce8f3190efa93c322e8dd412",
"assets/assets/top3.png": "466f13a986b4dc5f56acf62b684beeeb",
"assets/assets/%2520Character/Ping/Ping_card.jpg": "d5323a2af5236af8353cb3bbd68ed1d9",
"assets/assets/%2520Character/Ping/Ping%2520Proflie_Full%2520result.png": "a2560796627040e37facfcfe047d3d93",
"assets/assets/%2520Character/Ping/Icon%2520Activities/Beach%2520Bonfire.svg": "790f50228ba6bc7f5e0153c1a8be5581",
"assets/assets/%2520Character/Ping/Icon%2520Activities/Seafood%2520Hunt.svg": "428f9c74644653b166dfa174a2c556c5",
"assets/assets/%2520Character/Ping/Icon%2520Activities/Coastal%2520Ride.svg": "9a083b642673ade98d44d2e7fb037fe1",
"assets/assets/%2520Character/Ping/Icon%2520Activities/Kayaking.svg": "a3016601af63444a01ec100c56b76aa4",
"assets/assets/%2520Character/Ping/Icon%2520Activities/Snorkeling.svg": "d497f40efad96390bf9528f09b827dbd",
"assets/assets/%2520Character/Ping/Icon%2520Activities/Diving%2520Trip.svg": "69b4b2beef671da2a33f5a3bfda55f56",
"assets/assets/%2520Character/Ping/Dugong.png": "3269213aa8fec299bfff18aa38480eb1",
"assets/assets/%2520Character/Ping/Ping%2520result_EN.jpg": "cecf1fe5c0bfab36bab0bb0eff661505",
"assets/assets/%2520Character/Chai/Chai%2520Result_EN.jpg": "29b3ead56267c174fc984137aa663e65",
"assets/assets/%2520Character/Chai/Chai%2520Proflie_Full%2520result.png": "64c4fbb5f4cf7399e3c5a856cb5f8c24",
"assets/assets/%2520Character/Chai/Icon%2520Activities/Mindfulness.svg": "bbeb049f51839c5b07b0e60e3a62fc27",
"assets/assets/%2520Character/Chai/Icon%2520Activities/Farm%2520Walk.svg": "a1d2e1ea500ba20e55c1aee8d1d89a69",
"assets/assets/%2520Character/Chai/Icon%2520Activities/Soft%2520Adventure.svg": "012565c385753c0c7b8e1243971f5ae0",
"assets/assets/%2520Character/Chai/Icon%2520Activities/Homestay.svg": "cc19d93e697cbb8445c70f471f4dccd0",
"assets/assets/%2520Character/Chai/Icon%2520Activities/Reading%2520by%2520River.svg": "9793bbe60f7e7aba74482524db82781e",
"assets/assets/%2520Character/Chai/Icon%2520Activities/Market%2520Breakfast.svg": "923788dc77396ea5ebc22a7979cc3fcb",
"assets/assets/%2520Character/Chai/Chai_card.jpg": "28ff0469412a2b12732fc4489b70c335",
"assets/assets/%2520Character/Pla%2520kad/Pla%2520kad%2520Proflie_Full%2520result.png": "33f10d561f5eb8bacbf726ebc301ffdb",
"assets/assets/%2520Character/Pla%2520kad/Icon%2520Activities/Luxury%2520Spa.svg": "d3964710e3f75e64eb17ba7128cb09c1",
"assets/assets/%2520Character/Pla%2520kad/Icon%2520Activities/Fine%2520Dining.svg": "8e077de02eab9848feb6f01fda5494e2",
"assets/assets/%2520Character/Pla%2520kad/Icon%2520Activities/Festivals.svg": "f24800fd354eb840409913f1efdcc7ef",
"assets/assets/%2520Character/Pla%2520kad/Icon%2520Activities/Fashion.svg": "8e3260ddd25820f7795a25ea1722f67a",
"assets/assets/%2520Character/Pla%2520kad/Icon%2520Activities/Art%2520Gallery.svg": "91dbda6bd3b6b3caeee7a4b1f9a0597f",
"assets/assets/%2520Character/Pla%2520kad/Icon%2520Activities/Beachfront%2520Resort.svg": "00b2c96af58ad53ae372069753c42319",
"assets/assets/%2520Character/Pla%2520kad/Pla%2520kad%2520result_EN.jpg": "8d0a229df6b7d8c1566dc92648d68aee",
"assets/assets/%2520Character/Pla%2520kad/Pla%2520kad_card.jpg": "628be108fbdc08aa3a10fc172be70915",
"assets/assets/%2520Character/Pla%2520kad/Betta%2520Fish.png": "8fdcbb72529ec80528dc3ba6352950c3",
"assets/assets/%2520Character/Pla%2520kad/Background_Pla%2520kad.jpg": "fcc30d8d0f22c27614361f7b2e4a254e",
"assets/assets/%2520Character/Mali/Icon%2520Activities/Art%2520Walk.svg": "4c2f0de858639542b713c6fd32985ad5",
"assets/assets/%2520Character/Mali/Icon%2520Activities/Rooftop%2520Dining.svg": "6fff8a58f69620a95427d4d04f58b2db",
"assets/assets/%2520Character/Mali/Icon%2520Activities/Design%2520Market.svg": "2d71f3bce21fb426c058e7207b0ffa5a",
"assets/assets/%2520Character/Mali/Icon%2520Activities/Contemporary%2520Festivals.svg": "d211ad69ab488a9fbbfdd29cfafc05cf",
"assets/assets/%2520Character/Mali/Icon%2520Activities/Boutique%2520Stay.svg": "6abb0c8574e6aefaa583890e4a0f41ba",
"assets/assets/%2520Character/Mali/Icon%2520Activities/CafeHopping.svg": "3b46ab750bfeb62a8805cc0bacbd4abe",
"assets/assets/%2520Character/Mali/Mali%2520Result_EN.jpg": "10863055bcb7db372d2499d2030d4d56",
"assets/assets/%2520Character/Mali/mali_card.jpg": "0f15ea5d04ff4eae17b9f4b421e686bf",
"assets/assets/%2520Character/Mali/Mali%2520Proflie_Full%2520result.png": "8ad003c680b56ca8d3861641a7a79760",
"assets/assets/%2520Character/Mali/Siamese%2520Cat.jpg": "2614ef0550c0332510d013a62d8fd7d4",
"assets/assets/%2520Character/Chang%2520noi/Elephant.png": "10aa96fc2ae2639f327fa1a3613c7f5d",
"assets/assets/%2520Character/Chang%2520noi/Chang%2520noi_card.jpg": "202f47631483f36e6a35b86cb045c13e",
"assets/assets/%2520Character/Chang%2520noi/Icon%2520Activities/Cooking%2520Class.svg": "d3855bf8edb02c6a2209e5f3a9291c45",
"assets/assets/%2520Character/Chang%2520noi/Icon%2520Activities/Traditional%2520Festival.svg": "e6d3e5dd3ab396400969ee02c54ba6fd",
"assets/assets/%2520Character/Chang%2520noi/Icon%2520Activities/Craft%2520Workshop.svg": "2f36c4335ce841c92d168b51a77ba215",
"assets/assets/%2520Character/Chang%2520noi/Icon%2520Activities/Local%2520Market.svg": "0cc0d107df5ec4c4d1d05e3db7438056",
"assets/assets/%2520Character/Chang%2520noi/Icon%2520Activities/Heritage%2520Temple%2520Tour.svg": "25f39191510dfc0fb8bbd1277690c143",
"assets/assets/%2520Character/Chang%2520noi/Icon%2520Activities/Vintage%2520Souvenir.svg": "dcacec1229a03369d0141684389c8c31",
"assets/assets/%2520Character/Chang%2520noi/Chang%2520noi%2520Result_EN.jpg": "bd8b19d6a4c105e8c5a3d835e6b4d0a3",
"assets/assets/%2520Character/Chang%2520noi/Chang%2520noi%2520Proflie_Full%2520result.png": "cc4192d2162ba04bf9458278ee6876b4",
"assets/assets/top2.png": "bf61b91124a94218d65e326e06bd4f5f",
"assets/assets/Ping%2520result%2520en.jpg": "128247da1dfbd7b62923c1a5c49e3b9d",
"assets/assets/Chang%2520noi%2520Result%2520sp.jpg": "61e2f54c6a88cdbc6e97989f1a84ec74",
"assets/assets/top1.png": "862ff5161b33fcb41ea54d22c5dcf130",
"assets/assets/Chang%2520noi%2520Result%2520en.jpg": "b6259a57ccdd3703c3d90cad715eac0e",
"assets/assets/Background_Ping.jpg": "6b99e44c69df143b5b2df8df82cff243",
"assets/assets/Background_Red.jpg": "ac045440662efd572d584240f506ad11",
"assets/assets/Ping%2520result%2520sp.jpg": "2f93ebbb669ad7e5c97870bf90eda784",
"assets/assets/Buffalo.png": "3de4b8876275337379246eb9b99c4fae",
"assets/assets/Background_Mali.png": "44c8d9f28f6792e354ea7a8f33a5a1e5",
"assets/assets/challenge.png": "bed4e2ff60fe59172413746fea73aecc",
"assets/assets/Background_Q8.jpg": "f01f045c225641345e7719c383f00add",
"assets/assets/Background_Q9.jpg": "7d0656333da9a5fe92dc56174f8e1f5b",
"assets/assets/dish.png": "06b83da6c343e80daf4738ef1ce7a97b",
"assets/assets/fest.png": "fd361a1d55026efba07d864e033c42f2",
"assets/assets/tatc.png": "57a77cbedfb14abd351224de12dd9297",
"assets/assets/bar.png": "bbc1438092a311b2b0de2353aa7ca098",
"assets/assets/indi.png": "01e5600e97fc30913300ab92f3213487",
"assets/assets/Info%2520layer2.png": "c09f00c10587518d6201ee9f3e138a6e",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01"};
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
