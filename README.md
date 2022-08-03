
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
