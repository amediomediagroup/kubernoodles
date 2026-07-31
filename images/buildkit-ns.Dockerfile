FROM moby/buildkit:latest
ENTRYPOINT ["buildkitd", "--oci-worker-no-process-sandbox"]
