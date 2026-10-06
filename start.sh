#!/bin/sh
# Start the service, seed the demo data from the video, then serve through nginx on 7860.
cd /app
PORT=8080 ./pocketful &   # internal; nginx serves the public port ($PORT on Render, 7860 by default)
until curl -sf http://127.0.0.1:8080/health >/dev/null; do sleep 0.2; done
seed() {
  EXP=$(date -u -d '+12 hours' +%Y-%m-%dT%H:%M:%SZ)
  sed "s/__EXP__/$EXP/" seed.json | curl -sf -X POST http://127.0.0.1:8080/_test/reset -H 'Content-Type: application/json' -d @- && echo "seeded, hold expires $EXP"
}
seed
# re-seed every 6 hours so the demo stays in its recorded state
( while sleep 21600; do seed; done ) &
sed -i "s/__PORT__/${PORT:-7860}/" /etc/nginx/http.d/default.conf
exec nginx -g 'daemon off;'
