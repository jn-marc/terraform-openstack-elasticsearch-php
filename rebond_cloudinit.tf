data "template_file" "rebond" {
  template = <<EOF
#!/bin/bash
cat > ~/.ssh/id_rsa <<PRIVATE_KEY
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAspu3vc62/2YM2NkoHAHyLRG9TCwR51vQIzm0nr4RFYN16EA7
QW9AQQF70UkcEy7G5VmicTiXo5x1WREXSX/Lyyl1cVz9Dw+jK5w+MJGdMH1905ug
NmsgPtAuuwuXt04rPXUZrok1pEBgncMQXeZkC7HM5PmGsEcCf2N3o9PTy9KXXPlM
kPqgHR0J43DdxYsymQDvZe2zNHfxL88JtewNOK/URxjw36vvSti1X8/avyouj3bc
yZ6k2B4ppMbLGRsKXrTIMaC9bE7y4tnzpALa/U6S5vu8MqY7cGSzhWLT0jijE4PK
YgL1opZwDG/sjRTUf9VQXcgHeM6ZdhhLYBiqsQIDAQABAoIBADkk6RypTpNYKzQW
BmcvmDQjQNVmJDRJg8ZBaDCBzyV68fZk1pCQ75Xcy6iiI4FfrfMjQn3HBX0rScA9
X538bU+K7DBg9/YhoqsJSjxv2kLxY5iYaiH/FEoEgW8Gvnu/XsZC+PyGmcr7be4L
wujIFapIMK3xx84OahYn1Ndtpo3HQiChb2Mbjjv39sAn66jfmJfiv+MiGHGizxM7
JJ7a44y12iuBJFmBdcW5h7w+QipscyIkLxdBB54WGqJP2gCjgtkkcN9l0RPg8TXw
cK4SCKg0PQBHBEEWvvu896aHbBQeJRiNnh3ZQ9M3CvJdE7Ld6xsy28EJL4357rRz
VEOJhqECgYEA19ImHVikhF+Qrg6C0hHWMe5MWF148KTetWhCCvN5BhqRu+dajgWW
g4NKUi0GuIV1+OzxTeS/dI4Rz/aRzPxwet7hVybQzVfXz15mVdcqATikz1oX52UY
R/WMn5ruMTF/9XrdkvG1JD79DLibmgOxkoKcWAkwiVKkhD3bomJdLv8CgYEA09wL
ipYQ8JMuK0l4NLb8+Cz1vYq6KV1a6OEdKWsJzhTrUbD3hsNaSf6m7zDCUOeUAeKz
cwPuJXVYVLGxX/lW0AEON0VVjFXhozBu2OkKlOG1tsw6/2MN/8Gbxbwri1aojBxH
ZIVoqE/Vk6iC4xfGUpRx1Avc7kmZ9WXsRE3y1k8CgYAZv7XSbH/8VxaA3bRX8c7X
WDH9nPFP7KuxgwXWHqRCySq3+2s/ZIVHnYNheIPDwhCIKWTEwVTiSAzx/d35Uejt
j+fcqQHibeeOkxmshiY5zRNEteACOHqEI1SquiZO8jPtCsKixHmzIFy6hs/xuR0X
eMPEcRw8VgLQ0DyDDC9H6wKBgG5nyNfy9mb4vGGwiuUly1Tl0TZymis+TEb6MYFJ
F7X+rtdGmufu3BmdjI8v4MPauwX0h0HT9YIt0ddpNp9mR/hj5G2nQzq78rdhYRLG
9025BkJ50fEPRNdYpP353tNhWLqTbh0TbQPxfsLRWUxRMngMhflUKVFAp+v7rpG1
8Wv/AoGAR6nQjxogvbiLOtu63WccasLD/bVsIBHvN4qaSOZXyd9pD7Q4ZqOruA7p
dE8SWhOScp2mpxKqyFE8YWfECVolwZ6yGtPtjOoo/ZAa2yVe+At57aij2rtGcuTL
UnoU4jvCeNjp5gZiVnO0y5ncaLB0Suq+mW3sOFhesz0h+O1kE0I=
-----END RSA PRIVATE KEY-----
PRIVATE_KEY
chmod 600 ~/.ssh/id_rsa
cat > ~/.ssh/id_rsa.pub <<PUBLIC_KEY
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCym7e9zrb/ZgzY2SgcAfItEb1MLBHnW9AjObSevhEVg3XoQDtBb0BBAXvRSRwTLsblWaJxOJejnHVZERdJf8vLKXVxXP0PD6MrnD4wkZ0wfX3Tm6A2ayA+0C67C5e3Tis9dRmuiTWkQGCdwxBd5mQLsczk+YawRwJ/Y3ej09PL0pdc+UyQ+qAdHQnjcN3FizKZAO9l7bM0d/Evzwm17A04r9RHGPDfq+9K2LVfz9q/Ki6PdtzJnqTYHimkxssZGwpetMgxoL1sTvLi2fOkAtr9TpLm+7wypjtwZLOFYtPSOKMTg8piAvWilnAMb+yNFNR/1VBdyAd4zpl2GEtgGKqx root@rebond
PUBLIC_KEY
chmod 644 ~/.ssh/id_rsa.pub
EOF
}

data "template_cloudinit_config" "rebond" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.rebond.rendered}"
  }
}
