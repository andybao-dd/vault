test "jwt_auth" "jwt_auth1" {
  weight = 20
  config {
    auth {
      # jwks_url = "jwks.com"
    }

    role {
      name            = "my-jwt-role"
      role_type       = "jwt"
      bound_audiences = ["https://vault.plugin.auth.jwt.test"]
      user_claim      = "https://vault/user"
    }
  }
}

test "userpass_auth" "userpass_test1" {
  weight = 20
  config {
    username = "test-user"
    password = "password"
  }
}

test "kvv2_read" "kvv2_read_test" {
  weight = 10
  config {
    numkvs = 100
  }
}

test "kvv2_write" "kvv2_write_test" {
  weight = 10
  config {
    numkvs = 10
    kvsize = 1000
  }
}

test "pki_issue" "pki_issue_test1" {
  weight = 10
  config {
    setup_delay="2s"
    root_ca {
      common_name = "benchmark.test"
    }
    intermediate_csr {
      common_name = "benchmark.test Intermediate Authority"
    }
    role {
      ttl = "10m"
      key_type = "ed25519"
    }
  }
}

#test "pki_sign" "pki_sign_test1" {
#  weight = 10
#  config {
#    setup_delay="2s"
#    root_ca {
#      common_name = "benchmark.test"
#    }
#    intermediate_csr {
#      common_name = "benchmark.test Intermediate Authority"
#    }
#    role {
#      ttl = "10m"
#    }
#    sign {
#      csr = "./MYCSR.csr"
#    }
#  }
#}

test "transit_sign" "transit_sign_test_1" {
  weight = 5
}

test "transit_verify" "transit_verify_test_1" {
  weight = 5
  config {
    verify {
      signature_algorithm = "pkcs1v15"
    }
  }
}

test "transit_encrypt" "transit_encrypt_test_1" {
  weight = 5
  config {
    payload_len = 128
    context_len = 32
    keys {
      convergent_encryption = true
      derived = true
      type = "aes128-gcm96"
    }
  }
}

test "transit_decrypt" "transit_decrypt_test_1" {
  weight = 5
  config {
    payload_len = 64
  }
}

test "ha_status" "ha_status_test_1" {
  weight = 5
}

test "seal_status" "seal_status_test_1" {
  weight = 5
}