# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased] - 

### Added
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
