function k8s-login
    set namespace $argv[1]

    if test -z "$namespace"
        echo "Usage: k8s-login NAMESPACE" >&2
        return 1
    end

    # Login to Vault first
    vault login -method=oidc role=aad
    or return 1

    # Get the token
    set token (vault write kubernetes/creds/port-forward kubernetes_namespace="$namespace" \
        | grep -E '^service_account_token' | awk '{ print $2 }')

    if test -z "$token"
        echo "Failed to get token" >&2
        return 1
    end

    # Configure kubectl - each command separately
    kubectl config set-credentials vault-user --token="$token"
    or return 1

    kubectl config set-context vault-context \
        --cluster=do-tor1-k8s-spatium-production-tor1 \
        --user=vault-user \
        --namespace=$namespace
    or return 1

    kubectl config use-context vault-context
end
