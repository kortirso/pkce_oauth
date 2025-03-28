use magnus::{function, prelude::*, Error, Ruby};
use pkce;

fn generate_limited_code_verifier(length: usize) -> String {
  String::from_utf8(pkce::code_verifier(length)).expect("REASON")
}

fn generate_code_verifier() -> String {
  generate_limited_code_verifier(128)
}

fn generate_code_challenge(code_verifier: String) -> String {
  pkce::code_challenge(&code_verifier.as_bytes())
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
  let module = ruby.define_module("PkceOauth")?;
  module.define_singleton_method("generate_limited_code_verifier", function!(generate_limited_code_verifier, 1))?;
  module.define_singleton_method("generate_code_verifier", function!(generate_code_verifier, 0))?;
  module.define_singleton_method("generate_code_challenge", function!(generate_code_challenge, 1))?;
  Ok(())
}
