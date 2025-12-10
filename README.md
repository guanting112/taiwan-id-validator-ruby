# Taiwan ID Validator (for Ruby)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

`taiwan_id_validator` is a lightweight and zero-dependency Ruby gem for validating Taiwan National IDs, Alien Resident Certificates (ARC), and Unified Business Numbers (UBN).

It supports:
- **Taiwan National ID** (中華民國身分證字號)
- **New Alien Resident Certificate** (新式外來人口統一證號) (Since 2021)
- **Old Alien Resident Certificate** (舊式外來人口統一證號)
- **Unified Business Number (UBN)**: Validates company tax IDs, fully supporting the latest logic (including the 7th-digit rule). (新舊格式的統一編號)

## Installation

```bash
gem install taiwan_id_validator
# or 
bundle add taiwan_id_validator
```

## Usage

```ruby
require 'taiwan_id_validator'

TaiwanIdValidator.valid?('A123456789') # true
TaiwanIdValidator.valid?('A824285055') # true
TaiwanIdValidator.valid?('G951582036') # true
TaiwanIdValidator.valid?('AC01234567') # true
TaiwanIdValidator.valid?('AC01234566') # false
TaiwanIdValidator.valid?('A123456788') # false

TaiwanIdValidator.valid_national_id?('A123456789') # true
TaiwanIdValidator.valid_national_id?('A123456788') # false

TaiwanIdValidator.valid_arc_id?('AC01234567') # true
TaiwanIdValidator.valid_arc_id?('AC01234565') # false

TaiwanIdValidator.valid_ubn?('00000000') # false
TaiwanIdValidator.valid_ubn?('22099131') # true
TaiwanIdValidator.valid_ubn?('84149961') # true
```