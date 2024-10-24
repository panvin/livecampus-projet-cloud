# Projet Cloud - Livecampus

## ECI P2025 - 21/10/24 to 25/10/24
## Auteur: Vincent PANOUILLERES

### Détails du projet

Ce projet détaille une infrastructure factice pour la société foodbox. 
Schéma bas Level de l'infrastructure dans `lls_final.drawio.png`

### 

- Cloner ce repo
- Installer [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Installer [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Configurer aws-cli avec la commande `aws configure'. Renseigner la région par défaut et la clé de connexion AWS
- Se placer dans le dossier du repo
- Créer le fichier terraforms.tfvars:
```
cidr_public_subnet      = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet     = ["10.0.3.0/24", "10.0.4.0/24"]
region                  = "eu-west-1"
db_name                 = "db_name_a_remplacer"
db_user                 = "db_user_a_remplacer"
db_password             = "db_password_a_remplacer"
db_engine               = "mysql"
db_engine_version       = "8.0"
db_family               = "mysql8.0"    
wp_version              = "6.6.2"
ec2_desired_capacity    = 2
ec2_max_instances       = 2
ec2_min_instances       = 1
```
- Initialiser le backend terraform  `terraform init`
- Pré-visualiser le déploiement     `terraform plan`
- Lancer le déploiement             `terraform plan`