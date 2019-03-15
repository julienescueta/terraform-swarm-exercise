provider "aws" {
  region     = "us-west-2"
  profile    = "cj-deployer"
}

resource "aws_instance" "cj" {
  ami           = "ami-095cd038eef3e5074"
  instance_type = "t2.micro"
  key_name      = "compassionjournal-aws-key"
  vpc_security_group_ids = [
    "sg-0c88cb85e1a072ac4"
  ]
  user_data     = "${file("install-docker.sh")}"
  provisioner "file" {
    source      = "./docker-compose.yml"
    destination = "/home/ec2-user/docker-compose.yml"
    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key  = "${file("/home/julien/compassionjournal-aws-key.pem")}"
    }
  }

}

resource "aws_eip" "ip" {
  instance = "${aws_instance.cj.id}"
}
