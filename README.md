# Pocketful — public demo

Live demo of the stage-4 Pocketful service built by the Revived four-seat dark factory
(WeAreDevelopers × Band Dark Factory hackathon). The service code is built unchanged from
https://github.com/Whom-m0rty/revived-pocketful-dark-factory at commit 3f718ca; this wrapper only
adds a proxy and the demo data shown in the video.

Log in as `ada@example.com` / `correct horse` (also `bob@…`, `cy@…`). Data is in memory and
resets every 6 hours.

Deploy: Render → New → Blueprint → this repository (uses `render.yaml`, free plan).
Locally: `docker build -t pocketful-demo . && docker run -p 7860:7860 pocketful-demo`.
