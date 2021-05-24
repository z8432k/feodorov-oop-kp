module FeodorovOopKp
  autoload :Command

  class SaveCommand < Command
    def execute
      @app.save
    end
  end

end
