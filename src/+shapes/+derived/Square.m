classdef Square < shapes.base.Shape
    %SQUARE Concrete square implementation for the shapes package.

    properties
        Name = "square"
    end

    properties (SetAccess = private)
        Side (1,1) double = 1
    end

    methods
        function obj = Square(varargin)
            %SQUARE Construct a unit square or a square with a given side.
            side = [];

            if nargin == 1
                side = varargin{1};
            end

            if nargin == 0
                return;
            end

            if nargin ~= 1
                error( ...
                    "shapes:Square:ConstructorArity", ...
                    "Square expects either zero inputs or exactly one input: side.");
            end

            shapes.base.Shape.validatePositiveScalar( ...
                side, ...
                "side", ...
                "shapes:Square:InvalidSide");

            obj.Side = side;
        end

        function a = area(obj)
            effectiveSide = obj.Side * obj.ScaleFactor;
            a = effectiveSide ^ 2;
        end

        function p = perimeter(obj)
            effectiveSide = obj.Side * obj.ScaleFactor;
            p = 4 * effectiveSide;
        end
    end
end
