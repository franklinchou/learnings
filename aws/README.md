# AWS

## Using sts `assume-role`

STS (Security Token Service) allows users to request temporary, limited-privilege credentials.

The `assume-role` command returns a set of temporary security credentials to allow the user to access AWS resources that are
not permissioned to the user's "normal" AWS account.

**Problem**: Jenkins is a main account user but ECR images are stored on the ETL account. If Jenkins were to push
images to the ETL account's ECR, it would need to appear as an ETL account user.

**Solution**:

1. First, create the policy that gives access to the desired AWS resource (in our case, we used the AWS managed `AmazonEC2ContainerRegistryFullAccess` policy).

2. Next, on the ETL account (the **destination** account) create a new role that gives access to the **source** account.
In IAM, go to Roles > Create Role > Another AWS Account > Provide the account number of the **source** account > Attach the
policy created in step 1.

3. If you did steps 1 & 2 correctly, there should be a new role created that has: (A) in the `Permissions` tab the desired policies
should be attached; and (B) in the `Trust relationships` tab the `Trusted entites` section should list the
**source** account's Amazon Account Number.

4. In the newly created account role (from step 2) copy the Role ARN.

5. Access the desired AWS resource (belonging to the **destination** account) from the source account by issuing the following:
`aws sts assume-role --role-arn {{copied-role-ARN}} --role-session-name {{session-name}}` (the session-name is just a descriptor
of the access session.

6. One more thing! In our case, in order to login to ECR we needed to provide the `--registry-id {{destination-account-id}}` to the
ECR login command. That flag tells the ECR `get-login` command to login to the account where the images are stored (in this
case the destination account), e.g., `eval $(aws ecr get-login --registry-id {{destination-account-id}} --no-include-email --region us-east-1 | sed 's|https://||')`.
(`aws ecr get-login` __generates__ a login token, but does not actually execute it; which is why it needs to be wrapped in `eval`)

## Applying new policies with "invalid principle" error

Check to ensure that all keys are valid. If there are invalid keys edit the raw json and remove all invalid keys at once.
