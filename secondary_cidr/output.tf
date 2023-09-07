output "secondary_subnet" {
    value = aws_subnet.secondary_subnet[*].id

}