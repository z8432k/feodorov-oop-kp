module FeodorovOopKp
  class Command
    def initialize(app)
      @app = app
    end

    def execute
      fail NotImplementedError, "Class must be able to #execute!"
    end
  end
end
