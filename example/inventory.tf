
data "template_file" "inventory" {
  template = file("./inventory/inv_template.tpl")
  vars = {
    MGT         = join(" ", module.mgt-ec2.eip[*].public_ip)
    APPS        = join(" ", module.app-ec2.ec2_details[*].private_ip)
    # DB_MASTER   = join(" ", module.master_db.db_instance[*].address)
    # DB_REPLICA  = join(" ", module.replica.db_instance[*].address)
    ENV         = terraform.workspace
  }
}

resource "null_resource" "hosts" {
  triggers = {
    template_rendered = "${data.template_file.inventory.rendered}"
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory.rendered}' > ./inventory/prod"
  }
}
