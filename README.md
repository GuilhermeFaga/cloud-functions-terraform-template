
### Authenticating

To use or make any changes on GCP resources, you'll need to authenticate. Most apps will use the `GOOGLE_APPLICATION_CREDENTIALS` environment variable, that should have the path to your service account json file. More details on [Authenticating as a service account](https://cloud.google.com/docs/authentication/production).

```sh
export GOOGLE_APPLICATION_CREDENTIALS="path/to/serviceaccount.json"
```

### Terraform

After doing any changes on the terraform files, go to your environment and make sure you run:

```sh
terraform init
terraform plan
```

And see if there are any errors.

You can run `terraform apply` to deploy your code directly from your pc. Altough, we recommend pushing your changes to the repository to run the CI on Cloud Build.

## Using non-official terraform image inside of Cloud Build

Reference: [GoogleCloudPlatform/cloud-builders-community/terraform](https://github.com/GoogleCloudPlatform/cloud-builders-community/tree/master/terraform)

You need to compile and upload this docker image into your project.

Run the command below into your Cloud Shell

```bash
gcloud builds submit --config=cloudbuild.yaml \
  --substitutions=_TERRAFORM_VERSION="1.1.7",_TERRAFORM_VERSION_SHA256SUM="e4add092a54ff6febd3325d1e0c109c9e590dc6c38f8bb7f9632e4e6bcca99d4"
```

Then on [cloudbuild.yaml](./cloudbuild.yaml) use `gcr.io/${PROJECT_ID}/terraform` instead of `hashicorp/terraform`.

Teste para o GitLab branch dataflow_mds
