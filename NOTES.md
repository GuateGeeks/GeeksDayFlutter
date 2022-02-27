## Renderer

We are using canvaskit as it improves the render results.

For development we required:

Create cors.json
```
[
  {
    "origin": ["*"],
    "method": ["GET"],
    "maxAgeSeconds": 3600
  }
]
```
Apply it for the bucket on gcp
```
gsutil cors set cors.json gs://geeksday-b61c9.appspot.com
```
