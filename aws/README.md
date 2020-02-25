# AWS

## Using sts `assume-role`

STS (Security Token Service) allows users to request temporary, limited-privilege credentials.

The `assume-role` command returns a set of temporary security credentials to allow the user to access AWS resources that are
not permissioned to the user's "normal" AWS account.

## Applying new policies with "invalid principle" error

Check to ensure that all keys are valid. If there are invalid keys edit the raw json and remove all invalid keys at once.
