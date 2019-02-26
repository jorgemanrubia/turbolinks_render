# turbolinks_render

[![Build Status](https://travis-ci.org/jorgemanrubia/turbolinks_render.svg?branch=master)](https://travis-ci.org/jorgemanrubia/turbolinks_render)

Use `render` in your Rails controllers and handle the response with Turbolinks. 

Turbolinks supports [`redirect_to`](https://github.com/turbolinks/turbolinks/blob/master/README.md#redirecting-after-a-form-submission) out of the box. But `render` is not supported and you have to use [workarounds for common things like dealing with forms](https://github.com/turbolinks/turbolinks/issues/85). This gem aims to fix that. 

I think Turbolinks/Rails should handle this officially. If you agree [you can vote for this idea](https://github.com/turbolinks/turbolinks-rails/issues/40).

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'turbolinks_render'
```

And then execute:
```bash
$ bundle
```

## Usage

By default, `render` will be handled by Turbolinks if these conditions are met:

- It's an ajax request
- It's not a `get` request
- It generates an html response (`text/html` content type)

When these conditions are met and `render` is used:

- The page content is replaced with the rendered content with Javascript. It uses Turbolinks to do this replacement, so it is pretty smart about keeping the `<head>` when it's identical, executing `<script>` elements, etc.
- An event `turbolinks:load` is dispatched

You can disable turbolinks on a given request with: 

```ruby
render turbolinks: false
```

### Configuration

You can invert the default behavior: never use turbolinks for rendering unless explicitly indicated. Create a file `config/initializers/turbolinks_render.rb` and toggle `turbolinks_render.render_with_turbolinks_by_default`:

```ruby
Rails.application.config.turbolinks_render.render_with_turbolinks_by_default = false
```

In this case, to use turbolinks you should write:

```ruby
render turbolinks: true
```

## Implementation notes

- It configures a rack middleware that intercept requests and modify responses when the expected conditions are met.
- It uses some internal Turbolinks classes to perform the rendering. This makes the DOM-update logic very smart but it could introduce problems with future Turbolink versions , since this does not belong to its public API. I'll do my best to keep things up to date.

## Example 

An [example](https://github.com/jorgemanrubia/rails-form-validations-example) and an [explanatory blog post](https://www.jorgemanrubia.com/2019/02/16/form-validations-with-html5-and-modern-rails/) are also available.

## Credits

- Original implementation based on [this idea by @nerdcave](https://github.com/turbolinks/turbolinks/issues/85#issuecomment-298347900).

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

