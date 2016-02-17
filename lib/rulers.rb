require "rulers/version"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"
require "rulers/controller"

module Rulers
  # Your code goes here...
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404,
          {'Content-Type' => 'text/html'}, []]
      end

      if env['PATH_INFO'] == '/'
        controller = HomeController.new(env)
        text = controller.send(:index)
        return [200, {'Content-Type' => 'text/html'},
         [text]]
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act)
        [200, {'Content-Type' => 'text/html'},
         [text]]
      rescue => e
        [200, {'Content-Type' => 'text/html'},
         ['There is something wrong' + e.inspect]]
      end
    end
  end
end
