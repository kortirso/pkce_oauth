use base64_url::escape;
use magnus::{function, prelude::*, Error, Ruby};
use rand::{thread_rng, Rng};
//use rand::distributions::Alphanumeric;
use sha256::digest;

fn generate_limited_code_verifier(length: usize) -> String {
  const CHARSET: &[u8] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZ\
                            abcdefghijklmnopqrstuvwxyz\
                            0123456789-_";
  let mut rng = thread_rng();
  (0..length)
    .map(|_| {
      let index = rng.gen_range(0..CHARSET.len());
      CHARSET[index] as char
    })
    .collect()
}

fn generate_code_verifier() -> String {
  generate_limited_code_verifier(128)
}

fn generate_code_challenge(code_verifier: String) -> String {
  escape(&digest(code_verifier)).to_string()
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
  let module = ruby.define_module("PkceOauth")?;
  module.define_singleton_method("generate_limited_code_verifier", function!(generate_limited_code_verifier, 1))?;
  module.define_singleton_method("generate_code_verifier", function!(generate_code_verifier, 0))?;
  module.define_singleton_method("generate_code_challenge", function!(generate_code_challenge, 1))?;
  Ok(())
}
