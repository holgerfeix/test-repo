META:
    name: Enable or verify strong IAM password policy in an AWS account
    provider: AWS
    category: BOOTSTRAP
    subcategory: Foundation
    template_id: 3a.aws_iam_password_policy.1
    version: v1
    description: Sets up or verifies the following IAM password policy for IAM users - sets minimum password length; requires symbols, numbers, uppercase characters, and lowercase characters; allows users to change password; prevents password reuse; establishes max password age, expire passwords, and hard expiry.

{% set minimum_password_length = params.get('minimum_password_length', '14') %}
{% set require_symbols = params.get('require_symbols', 'true') %}
{% set require_numbers = params.get('require_numbers', 'true') %}
{% set require_uppercase_characters = params.get('require_uppercase_characters', 'true') %}
{% set require_lowercase_characters = params.get('require_lowercase_characters', 'true') %}
{% set allow_users_to_change_password = params.get('allow_users_to_change_password', 'true') %}
{% set expire_passwords = params.get('expire_passwords', 'true') %}
{% set max_password_age = params.get('max_password_age', 90) %}
{% set password_reuse_prevention = params.get('password_reuse_prevention', 24) %}
{% set hard_expiry = params.get('hard_expiry', 'false') %}

IAM password policy is not strong:
  META:
    name: Enable or verify strong IAM password policy in an AWS account
    policy_description: "Sets up or verifies an IAM password policy for IAM users that sets a minimum password length; requires symbols, numbers, uppercase characters, and lowercase characters; allows users to change passwords; prevents password reuse; establishes max password age, expire passwords, and hard expiry."
    finding_description: "IAM password policy for IAM users doesn't adhere to one or more of these rules: minimum password length; requirement for symbols, numbers, uppercase characters, and lowercase characters; allow change of passwords; prevent password reuse; max password age, expire passwords, and hard expiry."
    parameters:
      minimum_password_length:
        name: Minimum password length
        description: Enforce minimum password length. Password length must be a whole number greater than or equal to 6 and less than or equal to 128.
        uiElement: text
      require_symbols:
        name: Require symbols
        description: Enable/Disable at least one non-alphanumeric character(!@#$%^&*()_+-=[]{}|').
        uiElement: boolean
      require_numbers:
        name: Require numbers
        description: Enable/Disable require at least one number.
        uiElement: boolean
      require_uppercase_characters:
        name: Require uppercase characters
        description: Enable/Disable require at least one uppercase letter from Latin alphabet (A-Z).
        uiElement: boolean
      require_lowercase_characters:
        name: Require lowercase characters
        description: Enable/Disable require at least one lowercase letter from Latin alphabet (a-z).
        uiElement: boolean
      allow_users_to_change_password:
        name: Allow users to change their own password
        description: Enable/Disable allow users to change their own password.
        uiElement: boolean
      expire_passwords:
        name: Enable password expiration
        description: Enable/Disable enable password expiration.
        uiElement: boolean
      max_password_age:
        name: Maximum password length
        description: Expire passwords in days
        uiElement: text
      password_reuse_prevention:
        name: Prevent password reuse
        description: Prevent password reuse. Remeber number of passwords. 
        uiElement: text
      hard_expiry:
        name: Password expiration requires administrator reset
        description: Enable/Disable hard expiration.
        uiElement: boolean
  aws.iam.password_policy.present:
  - name: password-policy
  - minimum_password_length: {{minimum_password_length}}
  - require_symbols: {{require_symbols}}
  - require_numbers: {{require_numbers}}
  - require_uppercase_characters: {{require_uppercase_characters}}
  - require_lowercase_characters: {{require_lowercase_characters}}
  - allow_users_to_change_password: {{allow_users_to_change_password}}
  - expire_passwords: {{expire_passwords}}
  - max_password_age: {{max_password_age}}
  - password_reuse_prevention: {{password_reuse_prevention}}
  - hard_expiry: {{hard_expiry}}
