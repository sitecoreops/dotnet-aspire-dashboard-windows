
# inspired by the official linux image: https://github.com/dotnet/dotnet-docker/blob/main/src/aspire-dashboard/9.0/cbl-mariner-distroless/amd64/Dockerfile
ARG PARENT_IMAGE=

# ---
FROM ${PARENT_IMAGE}

ARG ASPIRE_VERSION=

WORKDIR /app

ENV DOTNET_ASPIRE_VERSION=${ASPIRE_VERSION}

RUN ECHO Installing Aspire Dashboard v%DOTNET_ASPIRE_VERSION%... \
    && curl -fSsL --output ./aspire_dashboard.zip https://ci.dot.net/public/aspire/%DOTNET_ASPIRE_VERSION%/aspire-dashboard-linux-x64.zip \
    && tar -xf ./aspire_dashboard.zip \
    && del .\\aspire_dashboard.zip

ENV ASPNETCORE_HTTP_PORTS= \
    ASPNETCORE_URLS=http://0.0.0.0:18888 \
    DOTNET_DASHBOARD_OTLP_ENDPOINT_URL=http://0.0.0.0:18889

ENTRYPOINT [ "dotnet", "/app/Aspire.Dashboard.dll" ]