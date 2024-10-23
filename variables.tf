variable "cidr_public_subnet" {
    type        = list(string)
    description = "List of cidr public subnet"
}
variable "cidr_private_subnet" {
    type        = list(string)
    description = "List of cidr private subnet"
}
variable "region" {
    type        = string
    description = "AWS server region"
    default     = "eu-west-1"
}
variable "db_name" {
    type        = string
    description = "Name of the wordpress' database"
}
variable "db_user" {
    type        = string
    description = "Wordpress database user"
}
variable "db_password" {
    type        = string
    description = "Wordpress database password"
}
variable "db_engine" {
    type        = string
    description = "Database engine"
    default     = "mysql"
}
variable "db_engine_version" {
    type        = string
    description = "Database engine version"
    default     = "8.0"
}
variable "db_family" {
    type = string
    description = "Database configuration family"
    default = "mysql8.0"
}
variable "wp_version" {
    type = string
    description = "Wordpress' version for ec2 instances"
}
variable "ec2_desired_capacity" {
    type = number
    description = "Autoscaler desired capacity"
}
variable "ec2_max_instances" {
    type = number
    description = "Autoscaler max number of instance"
}
variable "ec2_min_instances" {
    type = number
    description = "Autoscaler min number of instance"
}