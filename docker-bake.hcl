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
    "${COMMIT_SHA}",
    "latest"
  ]
  cache_to = [
    "type=gha,mode=max"
  ]
  cache_from = [
    "type=gha"
  ]
}