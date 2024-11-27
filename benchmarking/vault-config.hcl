storage "file" {
  path = "/scratch/vault-storage"
}

#storage "s3" {
#  bucket = "andyb-testing-234234"
#}


telemetry {
  # Disable usage gauges for perf and consistency
  usage_gauge_period = "0m"
  statsd_address = "statsd:8125"
}