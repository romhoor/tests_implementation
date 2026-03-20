classdef Rectangle < shapes.base.Shape
    %RECTANGLE Concrete rectangle implementation for the shapes package.

    properties
        Name = "rectangle"
    end

    properties (SetAccess = private)
        Width  (1,1) double = 1
        Height (1,1) double = 1
    end

    methods
        function obj = Rectangle(varargin)
            %RECTANGLE Construct a unit rectangle or a rectangle with size.
            width = [];
            height = [];

            if nargin == 2
                width = varargin{1};
                height = varargin{2};
            end

            if nargin == 0
                return;
            end

            if nargin ~= 2
                error( ...
                    "shapes:Rectangle:ConstructorArity", ...
                    "Rectangle expects either zero inputs or exactly two inputs: width and height.");
            end

            shapes.base.Shape.validatePositiveScalar( ...
                width, ...
                "width", ...
                "shapes:Rectangle:InvalidWidth");
            shapes.base.Shape.validatePositiveScalar( ...
                height, ...
                "height", ...
                "shapes:Rectangle:InvalidHeight");

            obj.Width = width;
            obj.Height = height;
        end

        function a = area(obj)
            effectiveWidth = obj.Width * obj.ScaleFactor;
            effectiveHeight = obj.Height * obj.ScaleFactor;
            a = effectiveWidth * effectiveHeight;
        end

        function p = perimeter(obj)
            effectiveWidth = obj.Width * obj.ScaleFactor;
            effectiveHeight = obj.Height * obj.ScaleFactor;
            p = 2 * (effectiveWidth + effectiveHeight);
        end
    end
end
