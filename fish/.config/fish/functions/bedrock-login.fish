function bedrock-login
    aws sso login --profile bedrock 2>/dev/null
    set -gx AWS_ACCESS_KEY_ID (aws configure export-credentials --profile bedrock --format env-no-export 2>/dev/null | grep '^AWS_ACCESS_KEY_ID=' | string replace 'AWS_ACCESS_KEY_ID=' '')
    set -gx AWS_SECRET_ACCESS_KEY (aws configure export-credentials --profile bedrock --format env-no-export 2>/dev/null | grep '^AWS_SECRET_ACCESS_KEY=' | string replace 'AWS_SECRET_ACCESS_KEY=' '')
    set -gx AWS_SESSION_TOKEN (aws configure export-credentials --profile bedrock --format env-no-export 2>/dev/null | grep '^AWS_SESSION_TOKEN=' | string replace 'AWS_SESSION_TOKEN=' '')
    set -gx AWS_REGION us-east-1
end
