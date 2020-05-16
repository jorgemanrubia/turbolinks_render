# Changelog

## [0.9.2](https://github.com/jorgemanrubia/turbolinks_render/pull/27)

- Add configuration to ignore paths (by Andrew Radev)

## 0.9.17

- Bump versions for several dependencies

## [0.9.16](https://github.com/jorgemanrubia/turbolinks_render/pull/18)

- Switch the order of scrolling and event triggering to enable persisting scroll

## [0.9.15](https://github.com/jorgemanrubia/turbolinks_render/pull/15)

- Trigger `turbolinks:before-cache` when rendering pages

## 0.9.13

- Make sure the content size is set as a string to [prevent problems with pow](https://github.com/basecamp/pow/issues/32).

## [0.9.12](https://github.com/jorgemanrubia/turbolinks_render/pull/13)

- Don't handle empty responses with Turbolinks

## [0.9.11](https://github.com/jorgemanrubia/turbolinks_render/pull/11)

- Fix problem with active storage
- Performance improvements

## [0.9.10](https://github.com/jorgemanrubia/turbolinks_render/pull/8)

- Use turbolinks code to replace page contents

## [0.9.9](https://github.com/jorgemanrubia/turbolinks_render/pull/6)

- Rewritten using a rack middleware instead of patching `render`. Thanks to @excid3 for detailed report.
- Execute `<script>` elements in responses

## 0.9.1

- Initial release
