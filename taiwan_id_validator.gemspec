# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "taiwan_id_validator"
  spec.version       = "1.0.0"
  spec.authors       = ["Guanting112"]

  spec.summary       = "A validator for Taiwan National ID, ARC, and UBN (Company Tax ID)"
  spec.description   = "快速驗證台灣身分證、居留證、統一編號 / Validates Taiwan National ID (Citizen), Alien Resident Certificate (ARC, both old and new formats), and Unified Business Number (UBN)."
  spec.homepage      = "https://github.com/guanting112/taiwan-id-validator"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{lib}/**/*", "LICENSE", "README.md"]
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.0"
end
