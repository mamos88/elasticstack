# Elasticsearch Data Hot ASG
resource "aws_autoscaling_group" "elasticsearchDataHotASG" {
    name = "elasticsearchDataHotASG"
    max_size = 1
    min_size = 1

    vpc_zone_identifier = [for subnet in aws_subnet.elasticsearch-lab-pub: subnet.id]
    
    launch_template {
        id = aws_launch_template.ElasticsearchDataHotLC.id
        version = "$Latest"
    }

    # target_group_arns = ["${aws_lb_target_group.test.arn}"]

    tag {
      key = "Name"
      value = "elasticsearch-Data-Hot"
      propagate_at_launch = true
    }
}

# Elasticsearch Data Warm ASG
resource "aws_autoscaling_group" "elasticsearchDataWarmASG" {
    name = "elasticsearchDataWarmASG"
    max_size = 0
    min_size = 0

    vpc_zone_identifier = [for subnet in aws_subnet.elasticsearch-lab-pub: subnet.id]
    
    launch_template {
        id = aws_launch_template.ElasticsearchDataWarmLC.id
        version = "$Latest"
    }

    # target_group_arns = ["${aws_lb_target_group.test.arn}"]

    tag {
      key = "Name"
      value = "elasticsearch-Data-Warm"
      propagate_at_launch = true
    }
}

# Elasticsearch Data Cold ASG
resource "aws_autoscaling_group" "elasticsearchDataColdASG" {
    name = "elasticsearchDataColdASG"
    max_size = 0
    min_size = 0

    vpc_zone_identifier = [for subnet in aws_subnet.elasticsearch-lab-pub: subnet.id]
    
    launch_template {
        id = aws_launch_template.ElasticsearchDataColdLC.id
        version = "$Latest"
    }

    # target_group_arns = ["${aws_lb_target_group.test.arn}"]

    tag {
      key = "Name"
      value = "elasticsearch-Data-Cold"
      propagate_at_launch = true
    }
}

# Elasticsearch Data Content ASG
resource "aws_autoscaling_group" "elasticsearchDataContentASG" {
    name = "elasticsearchDataContentASG"
    max_size = 1
    min_size = 1

    vpc_zone_identifier = [for subnet in aws_subnet.elasticsearch-lab-pub: subnet.id]
    
    launch_template {
        id = aws_launch_template.ElasticsearchDataContentLC.id
        version = "$Latest"
    }

    # target_group_arns = ["${aws_lb_target_group.test.arn}"]

    tag {
      key = "Name"
      value = "elasticsearch-Data-Content"
      propagate_at_launch = true
    }
}

# Kibana ASG
resource "aws_autoscaling_group" "KibanaASG" {
    name = "KibanaASG"
    max_size = 1
    min_size = 1

    vpc_zone_identifier = [for subnet in aws_subnet.elasticsearch-lab-pub: subnet.id]
    
    launch_template {
        id = aws_launch_template.KibanaLC.id
        version = "$Latest"
    }

    # target_group_arns = ["${aws_lb_target_group.test.arn}"]

    tag {
      key = "Name"
      value = "Kibana"
      propagate_at_launch = true
    }
}