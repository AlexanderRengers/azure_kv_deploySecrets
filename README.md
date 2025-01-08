# Goal
All secrets should be created through bicep deployment with dummy values.
After successfull deployment the dummy values are manually updated to reflect the actual values.

# Problem
After manually updating the secret values from `<dummy>` to `<actualValue>`, subsequent bicep deployments will overwrite the value back to `<dummy>`.

# Solution
- The deployment checks with a CLI command wheter there are deployment outputs from a previous deployment. At initial state, that will be false and therefore a
empty json array is passed as input parameter into the bicep template.
- The bicep template checks for every secret if the secret name is already in the input array present and deploys only if not so.
- Finally the deployment outputs an array with all secrets successfully deployed.
- The subsequent deployment checks the array and doesn't deploy already existing secrets.