# Stage 1
FROM hashicorp/terraform:1.3.4 AS terraform-deps

# Stage 2
FROM google/cloud-sdk:409.0.0-slim

RUN gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true

COPY --from=terraform-deps /bin/terraform /bin/terraform

## Pre-install providers

WORKDIR /tmp

COPY providers.tf .

RUN terraform init && terraform providers mirror --platform=linux_amd64 /opt/offline-tf-providers

RUN rm providers.tf && rm -r .terraform

## Setup script

WORKDIR /src

COPY ./config-gcloud /usr/local/bin/config-gcloud

CMD chmod +x /usr/bin/config-gcloud

ENTRYPOINT ["config-gcloud"]

CMD ["tail", "-F", "/dev/null"]