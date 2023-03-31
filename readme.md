# Azure Container Apps Shared Infrastructure

The shared infrastructure required to support the [container apps](https://github.com/jsacapdev/az.frontdoor.container.apps).

On Azure, aims to be a very simple hub, in a hub and spoke architecture. Should only be short-lived (i.e. does not use Bastion over the virtual machine).

I find it useful to spin it up quickly and check resources that sit behind private IP's or endpoints.

[![Deploy Infrastructure](https://github.com/jsacapdev/az.frontdoor.container.shared/actions/workflows/deploy-iac.yaml/badge.svg)](https://github.com/jsacapdev/az.frontdoor.container.shared/actions/workflows/deploy-iac.yaml)
