classdef TestSquare < Shape
    %TESTSQUARE
    %
    % Minimal concrete subclass used to demonstrate the parent Shape
    % interface with a square implementation.

    properties
        %NAME
        %
        % Concrete value for the abstract property defined by Shape.
        Name = "square"
    end

    properties (SetAccess = private)
        %SIDE
        %
        % Unscaled side length of the square.
        Side (1,1) double = 1
    end

    methods
        function obj = TestSquare(side)
            %TESTSQUARE
            %
            % Construct a default unit square or a square with the supplied
            % side length.

            if nargin == 0
                return;
            end

            if nargin ~= 1
                error( ...
                    "TestSquare:ConstructorArity", ...
                    "Constructor expects either zero inputs or exactly one input: side.");
            end

            Shape.validatePositiveScalar( ...
                side, ...
                "side", ...
                "TestSquare:InvalidSide");

            obj.Side = side;
        end

        function a = area(obj)
            %AREA
            %
            % Area after applying the inherited scale factor.

            effectiveSide = obj.Side * obj.ScaleFactor;
            a = effectiveSide ^ 2;
        end

        function p = perimeter(obj)
            %PERIMETER
            %
            % Perimeter after applying the inherited scale factor.

            effectiveSide = obj.Side * obj.ScaleFactor;
            p = 4 * effectiveSide;
        end
    end
end
