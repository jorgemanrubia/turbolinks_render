# turbolinks_render

This gem lets you use regular `render` in your Rails controllers and handle the response with Turbolinks. 

Turbolinks supports [`redirect_to`](https://github.com/turbolinks/turbolinks/blob/master/README.md#redirecting-after-a-form-submission) out of the box. But `render` is not supported and you have to use workarounds for common things like [dealing with forms](https://github.com/turbolinks/turbolinks/issues/85). This gem aims to fix that. 

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'turboilnks_render'
```

And then execute:
```bash
$ bundle
```

## Usage

By default, when using `render`, the response is going to be handled by Turbolinks if these conditions are met:

- It's an ajax request
- It's not a `get` request
- It's not rendering json

You can disable turbolinks for a given response: 

```ruby
render turbolinks: false
```

### Configuration

You can invert the default behavior: never use turbolinks for rendering unless explicitly indicated. Create a file `config/initializers/turbolinks_render.rb` and toggle `turbolinks_render.render_with_turbolinks_by_default`:

```ruby
Rails.application.config.turbolinks_render.render_with_turbolinks_by_default = false
```

In this case, to use turbolinks in a given response you should write:

```ruby
render turbolinks: true
```

## Credits

- [Implementation is based on this idea by @nerdcave](https://github.com/turbolinks/turbolinks/issues/85#issuecomment-298347900).  

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

