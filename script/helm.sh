#!/bin/sh -eu

helm upgrade --install morning-night-guild-platform ./k8s --namespace=morning-night-dreamer --values ./k8s/values.yaml --values ./k8s/env/prod/values.yaml
