region = "eu-west-1"

ec2_config = {
  instance_type = "t3.micro"
  v_size = 30
  v_type = "gp3"
}

additional_tags = {
  DEPT = "QA"
  PROJECT = "MYPROJECT_QA"
}