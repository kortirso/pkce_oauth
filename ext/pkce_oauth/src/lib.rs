use magnus::{function, prelude::*, Error, Ruby};
use rand::{thread_rng, Rng};
use rand::distributions::Alphanumeric;
use sha256::digest;

fn generate_limited_code_verifier(length: usize) -> String {
  thread_rng()
    .sample_iter(&Alphanumeric)
    .take(length)
    .map(char::from)
    .collect()
}

fn generate_code_verifier() -> String {
  generate_limited_code_verifier(128)
}

fn generate_code_challenge(code_verifier: String) -> String {
  digest(code_verifier)
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
  let module = ruby.define_module("PkceOauth")?;
  module.define_singleton_method("generate_limited_code_verifier", function!(generate_limited_code_verifier, 1))?;
  module.define_singleton_method("generate_code_verifier", function!(generate_code_verifier, 0))?;
  module.define_singleton_method("generate_code_challenge", function!(generate_code_challenge, 1))?;
  Ok(())
}
