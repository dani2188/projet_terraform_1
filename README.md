# projet_terraform_1

# exo 1:
### Visualisation des dépendences avec la commande: $ terraform graph

digraph {
        compound = "true"
        newrank = "true"
        subgraph "root" {
                "[root] aws_instance.app_server (expand)" [label = "aws_instance.app_server", shape = "box"]
                "[root] aws_security_group.instance (expand)" [label = "aws_security_group.instance", shape = "box"]
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" [label = "provider[\"registry.terraform.io/hashicorp/aws\"]", shape = "diamond"]
                "[root] var.security_group_name" [label = "var.security_group_name", shape = "note"]
                "[root] aws_instance.app_server (expand)" -> "[root] aws_security_group.instance (expand)"
                "[root] aws_security_group.instance (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
                "[root] aws_security_group.instance (expand)" -> "[root] var.security_group_name"
                "[root] output.public_ip (expand)" -> "[root] aws_instance.app_server (expand)"
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_instance.app_server (expand)"
                "[root] root" -> "[root] output.public_ip (expand)"
                "[root] root" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)"
        }
}



# exo 3:
Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
Outputs:
public_ip = "terraform-20230207152430174400000001"

### Visualisation des dépendences avec la commande: $ terraform graph
$ terraform graph
digraph {
        compound = "true"
        newrank = "true"
        subgraph "root" {
                "[root] aws_autoscaling_group.example (expand)" [label = "aws_autoscaling_group.example", shape = "box"]
                "[root] aws_launch_configuration.example (expand)" [label = "aws_launch_configuration.example", shape = "box"]
                "[root] aws_security_group.instance (expand)" [label = "aws_security_group.instance", shape = "boup.example (expand)"
                "[root] root" -> "[root] output.public_ip (expand)"                "[root] root" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)"
        }
}
