data "template_file" "shell-script" {
  template = "${file("../modules/instances/scripts/app-init.sh")}"
}

data "template_cloudinit_config" "config" {

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.shell-script.rendered}"
  }
}
