
variable "vpc_cidr_block" {
    type = string
    description = "use this vpc cidr block"
   
}

variable "subnet_cidr_block" {
    type = string
    
  
}

variable "az" {
    type = list(string)

  
}

variable "port_no" {
  type = list(number)
  
}

variable "ami_id" {
    type = string
    
  
}

variable "instance_type" {
    type = string
    
  
}

variable "key" {
    type = string

}

# variable holds the name of the variable
# data types:
# 1. string --> consists of aplphanumeric characters
# 2. number --> consists of numbers only
# 3. bool   --> consists of yes or no
# 4. list --> consists of list of string or number
# 5. map --> consists of key value pairs
