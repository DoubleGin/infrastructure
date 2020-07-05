#!/bin/bash

# deploy the trained models provided by deepspeech into our GCS bucket for use by the deepworker processes.

wget -nc https://github.com/mozilla/DeepSpeech/releases/download/v0.7.4/deepspeech-0.7.4-models.pbmm
wget -nc https://github.com/mozilla/DeepSpeech/releases/download/v0.7.4/deepspeech-0.7.4-models.scorer

gsutil -m cp deepspeech-0.7.4-models.pbmm gs://oddmark-deepspeech-models-stage/
gsutil -m cp deepspeech-0.7.4-models.scorer gs://oddmark-deepspeech-models-stage/
