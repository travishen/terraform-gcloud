# Stage 1
FROM hashicorp/terraform:1.3.4 AS terraform-deps

# Stage 2
FROM google/cloud-sdk:409.0.0-slim

RUN gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true

COPY --from=terraform-deps /bin/terraform /bin/terraform

## Pre-install providers

WORKDIR /opt/offline-tf-providers

COPY providers.tf .

RUN terraform init && terraform providers mirror --platform=linux_amd64 .

RUN rm providers.tf && rm -r .terraform

## Pre-install modules

WORKDIR /opt/offline-tf-modules

COPY modules.tf .

RUN terraform init

RUN cp -r .terraform/modules/* .

RUN rm modules.tf && rm -r .terraform

## Setup script

WORKDIR /src

COPY ./config-gcloud /usr/local/bin/config-gcloud

CMD chmod +x /usr/bin/config-gcloud

ENTRYPOINT ["config-gcloud"]

CMD ["tail", "-F", "/dev/null"]