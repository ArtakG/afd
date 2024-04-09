module "afd" {
  source          = ".\\module"
  location        = "westeurope"
  location-prefix = "weu"
  name            = "frontdoortestag"
  custom-domain   = "learnit.solutions"
  allowed_ips     = ["46.241.153.142"]
  tags = {
    environment = "test"
    owner       = "terraform"
    createdBy   = "agabrielyan"
  }
}