
# inspired by the official linux image: https://github.com/dotnet/dotnet-docker/blob/2dab39f7f727e34f95ea09205b4c29c63f83932a/src/aspire-dashboard/9.4/azurelinux-distroless/amd64/Dockerfile
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

ENV \
    # Unset ASPNETCORE_HTTP_PORTS from base image
    ASPNETCORE_HTTP_PORTS= \
    # Aspire Dashboard environment variables
    ASPNETCORE_URLS=http://+:18888 \
    ASPIRE_DASHBOARD_OTLP_ENDPOINT_URL=http://+:18889 \
    ASPIRE_DASHBOARD_OTLP_HTTP_ENDPOINT_URL=http://+:18890 \
    ASPIRE_DASHBOARD_MCP_ENDPOINT_URL=http://+:18891

ENTRYPOINT [ "dotnet", "/app/Aspire.Dashboard.dll" ]