variable "IMAGE_NAME" {
  default = "$IMAGE_NAME"
}

variable "REGISTRY" {
  default = "$REGISTRY"
}

variable "REPOSITORY" {
  default = "${REGISTRY}/${IMAGE_NAME}"
}

variable "COMMIT_SHA" {
  default = "$COMMIT_SHA"
}

group "default" {
  targets = [
    "operator"
  ]
}


target "operator" {
  dockerfile = "Dockerfile"
  tags       = [
    "${REPOSITORY}:${COMMIT_SHA}",
    "${REPOSITORY}:latest"
  ]
  cache-to = [
    "type=gha,mode=max"
  ]
  cache-from = [
    "type=gha"
  ]
}