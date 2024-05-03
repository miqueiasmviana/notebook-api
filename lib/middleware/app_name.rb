class AppName
  def initialize(app)
    @app = app
  end
  
  def call(env)
    ['200', {'Content-Type' => 'text/html'}, ["Notebook API"]]
  end
 end

# # Em app/middleware/nome_do_middleware.rb
# class AppName
#   def initialize(app)
#     @app = app
#   end

#   def call(env)
#     [200, { "Content-Type" => "text/html" }, ["Notebook API"]]
#   end
# end

# class AppName
#   def initialize(app, message)
#     @app = app
#     @message = message
#   end
   
#   def call(env)
#     ['200', {'Content-Type' => 'text/html'}, [@message]]
#   end
# end