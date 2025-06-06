# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased] - 

### Fixed
- Fix compile error calling `.compare_versions` with `Haystack::VERSION`

## [2.0.0] - 2025-04-18

### Changed
- Convert `Haystack` to a `struct`
- Convert `Haystack::Bank::Account` to a `struct`
- Convert `Haystack::Dispute::Evidence` to a `struct`
- Convert `Haystack::Subscription::Invoice` to a `struct`

### Fixed
- Use the same `HTTP::Client` object for all `Haystack` instances

## [1.0.2] - 2024-08-15

### Fixed
- Add missing `require "http/client"`

## [1.0.1] - 2024-03-23

### Fixed
- Fix incorrect Paystack signature verification in webhook handler

## [1.0.0] - 2023-05-30

### Changed
- Rename `Haystack::Country::Relationships::Relationship` to `Haystack::Country::Relationship`

### Fixed
- Fix potential JSON parse errors in `.from_any` methods

## [0.6.0] - 2023-05-02

### Removed
- Remove `GrottoPress/hapi` shard

## [0.5.0] - 2023-05-02

### Changed
- Bump minimum required Crystal version to 1.3

### Fixed
- Fix linker error with OpenSSL 3.0

## [0.4.0] - 2023-01-12

### Added
- Add constants for accessing raw webhook events

## [0.3.0] - 2022-03-17

### Added
- Add `Haystack::Bank#deleted?` as an alias for `#is_deleted?`
- Add `Haystack::Dispute::Message#deleted?` as an alias for `#is_deleted?`
- Add `Haystack::Plan#deleted?` as an alias for `#is_deleted?`
- Add `Haystack::Recipient#deleted?` as an alias for `#is_deleted?`
- Ensure support for *Crystal* v1.3

### Changed
- Read HTTP responses from `body` instead of `body_io` in endpoint methods

### Removed
- Remove `Haystack::Recipient#isDeleted`
- Remove `Haystack::Recipient#isDeleted?`

## [0.2.1] - 2022-01-03

### Added
- Add support for *Crystal* v1.2

## [0.2.0] - 2021-08-17

### Added
- Add support for Paystack webhooks
- Add `#is_live` and `#business_name` attributes to `Haystack::Integration`
- Add missing `Haystack::Dispute::Status` members

### Changed
- Change amount types from `Int64` to `Int32`

### Changed
- Replace camelcased attributes with underscored methods in public API
- Return enum (instead of string) for `Haystack::Split#bearer_type`
- Rename `Haystack::Subscription::RecentInvoice` to `Invoice`
- Rename methods with abbreviated names to full names

### Fixed
- Fix wrong attribute types in `Haystack::Subscription::Invoice`
- Fix some attributes not captured from pending charge response

## [0.1.0] - 2021-07-13

### Added
- Initial public release
