classdef BrokenSquare < Shape
    methods
        function obj = BrokenSquare(side, scaleFactor)
            obj@Shape();   % WRONG: ignores scaleFactor
        end
    end

    methods (Access = protected)
        function a = computeArea(obj)
          a = -42;
          %   a = -pi * (obj.Radius * obj.ScaleFactor)^2;   % WRONG
        end

        function p = computePerimeter(obj)
          p = -42;
          %   p = -2 * pi * obj.Radius * obj.ScaleFactor;   % WRONG
        end
    end
end
