module ENV
  def self.fetch(key)
    fetch(key) do
      if block = @block
        block.call(self, key)
      else
        raise KeyError.new "Missing ENV key: #{key.inspect}"
      end
    end
  end

  def self.fetch(key, default)
    fetch(key) { default }
  end

  def self.fetch(key)
    return self[key] if has_key?(key)
    yield key
  end
end

require "amethyst"
require "./app/controllers/frontpage_controller"

class BerkshirelinksprojectApp < Base::App
  routes.draw do
    get "/", "frontpage#home"

    register FrontpageController
    use Middleware::HttpLogger
  end
end
app = BerkshirelinksprojectApp.new
app.serve(ENV.fetch("PORT", 3008).to_i)
