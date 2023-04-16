# For CasparHealth

 * This needs AWS Credentials in "default" profile mode and this AWS Credentials becomes default admin using system:masters group membership

 * Used Null_Resource LocalProvisioner to  run "aws update-kubeconfig" command to append Clusterconfig to kubeconfig

 * aws_auth configmap not part of this , can be done later