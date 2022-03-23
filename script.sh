#!/bin/bash
touch "archivo_prueba$(date +_%Y%m%d_%H%M).txt"
gcloud pubsub subscriptions pull example-subscription --format=json >> "archivo_prueba$(date +_%Y%m%d_%H%M).txt"
gsutil cp "archivo_prueba$(date +_%Y%m%d_%H%M).txt" gs://bucket-alexverb-task1