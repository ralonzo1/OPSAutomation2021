resource "aws_route53_record" "tfer--Z08235522EHXO8MKK0AI0_bridges2safetyonline-002E-com-002E-_A_" {
  name    = "bridges2safetyonline.com"
  records = ["44.239.191.199"]
  ttl     = "300"
  type    = "A"
  zone_id = aws_route53_zone.tfer--Z08235522EHXO8MKK0AI0_bridges2safetyonline-002E-com.zone_id
}

resource "aws_route53_record" "tfer--Z08235522EHXO8MKK0AI0_bridges2safetyonline-002E-com-002E-_NS_" {
  name    = "bridges2safetyonline.com"
  records = ["ns-193.awsdns-24.com.", "ns-1378.awsdns-44.org.", "ns-1658.awsdns-15.co.uk.", "ns-642.awsdns-16.net."]
  ttl     = "172800"
  type    = "NS"
  zone_id = aws_route53_zone.tfer--Z08235522EHXO8MKK0AI0_bridges2safetyonline-002E-com.zone_id
}

resource "aws_route53_record" "tfer--Z08235522EHXO8MKK0AI0_bridges2safetyonline-002E-com-002E-_SOA_" {
  name    = "bridges2safetyonline.com"
  records = ["ns-1658.awsdns-15.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl     = "900"
  type    = "SOA"
  zone_id = aws_route53_zone.tfer--Z08235522EHXO8MKK0AI0_bridges2safetyonline-002E-com.zone_id
}

resource "aws_route53_record" "tfer--Z08235522EHXO8MKK0AI0_www-002E-bridges2safetyonline-002E-com-002E-_A_" {
  name    = "www.bridges2safetyonline.com"
  records = ["44.239.191.199"]
  ttl     = "300"
  type    = "A"
  zone_id = aws_route53_zone.tfer--Z08235522EHXO8MKK0AI0_bridges2safetyonline-002E-com.zone_id
}
