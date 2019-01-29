resource "openstack_compute_keypair_v2" "local" {
  name       = "local"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAugJOlhEf9fBwH4v5Ob7QZlhQNbS9WTAVE13DLXxa+OrujNiwEWMskdCVup3fUBNg7WFsxQjuP8pjrjq7+vibNZGyqsorfCZb8kFbGSS3rbNRNFlK+K5dj+Tmy5z2+niRPjQoBKjh3UDRAOfKsMCc3UpmFKV8Zpl0ZbceM0wM2XhLmEWizr99qSFsgLXad6LB8fe8Ndk428OduZxLQV/TU633udG/H5cDQBJjiACXgubU7T39OUEdh7PKjltWu4Gn6Wz5rQVr3uzE/Vgv09esatIfTW0uiiXFbJiZ+kteI60TtlyqR7c6sv7dXDS+Sf89kPMyLFItklPT3HJ6MWMyVw== Marc@mac-pro-de-marc-gerini.local"
}

resource "openstack_compute_keypair_v2" "rebond" {
  name       = "demo_rebond"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCym7e9zrb/ZgzY2SgcAfItEb1MLBHnW9AjObSevhEVg3XoQDtBb0BBAXvRSRwTLsblWaJxOJejnHVZERdJf8vLKXVxXP0PD6MrnD4wkZ0wfX3Tm6A2ayA+0C67C5e3Tis9dRmuiTWkQGCdwxBd5mQLsczk+YawRwJ/Y3ej09PL0pdc+UyQ+qAdHQnjcN3FizKZAO9l7bM0d/Evzwm17A04r9RHGPDfq+9K2LVfz9q/Ki6PdtzJnqTYHimkxssZGwpetMgxoL1sTvLi2fOkAtr9TpLm+7wypjtwZLOFYtPSOKMTg8piAvWilnAMb+yNFNR/1VBdyAd4zpl2GEtgGKqx root@rebond"
}
