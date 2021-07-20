# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased] - 

### Added
- Add support for Paystack webhooks
- Add `#is_live` and `#business_name` attributes to `Haystack::Integration`
- Add environment variable for *Paystack* secret key
- Add missing `Haystack::Dispute::Status` members

### Changed
- Replace camelcased attributes with underscored methods in public API
- Return enum (instead of string) for `Haystack::Split#bearer_type`
- Rename `Haystack::Subscription::RecentInvoice` to `Invoice`

### Fixed
- Fix wrong attribute types in `Haystack::Subscription::Invoice`

## [0.1.0] - 2021-07-13

### Added
- Initial public release
