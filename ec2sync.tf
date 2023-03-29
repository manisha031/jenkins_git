import boto3

# Set up a Boto3 EC2 client
ec2 = boto3.client('ec2')

# Fetch all instances
response = ec2.describe_instances()

# Iterate over instances and generate Terraform code for each
for reservation in response['Reservations']:
    for instance in reservation['Instances']:
        # Get instance properties
        instance_id = instance['InstanceId']
        instance_type = instance['InstanceType']
        security_groups = [sg['GroupId'] for sg in instance['SecurityGroups']]
        subnet_id = instance['SubnetId']
        
        # Generate Terraform code
        tf_code = f"""resource "aws_instance" "{instance_id}" {{
  ami           = "{instance['ImageId']}"
  instance_type = "{instance_type}"
  vpc_security_group_ids = {security_groups}
  subnet_id = "{subnet_id}"
}}"""
        
        print(tf_code)
