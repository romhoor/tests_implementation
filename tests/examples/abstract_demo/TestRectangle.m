classdef TestRectangle < Shape
    %TESTRECTANGLE
    %
    % Minimal concrete subclass used to exercise the abstract superclass.
    %
    % This is intentionally simple and boring.
    % That is good for tests.
    %
    % Why?
    % Because when a test fails, we want the failure to point clearly either
    % to the superclass logic or to the contract implementation, not to some
    % fancy subclass behavior.

    properties
        %NAME
        %
        % Concrete realization of the abstract property declared in Shape.
        %
        % The superclass already declares the scalar-string contract.
        % Here we only provide the concrete value.
        %
        % This is intentional:
        % MATLAB rejects size/validation syntax on the subclass definition
        % of an inherited abstract property.
        Name = "rectangle"
    end

    properties (SetAccess = private)
        %WIDTH, HEIGHT
        %
        % Rectangle-specific state.
        %
        % Private write access keeps the demo clean:
        % we construct a valid object once and then only change the shared
        % scale factor through inherited API.

        Width  (1,1) double = 1
        Height (1,1) double = 1
    end

    methods
        function obj = TestRectangle(width, height)
            %TESTRECTANGLE
            %
            % Constructor.
            %
            % Usage:
            %   r = TestRectangle()
            %   r = TestRectangle(width, height)
            %
            % We keep the constructor strict and explicit so tests can rely on
            % stable, user-defined error identifiers.

            if nargin == 0
                % Keep defaults:
                %   Width  = 1
                %   Height = 1
                return;
            end

            if nargin ~= 2
                error( ...
                    "TestRectangle:ConstructorArity", ...
                    "Constructor expects either zero inputs or exactly two inputs: width and height.");
            end

            Shape.validatePositiveScalar( ...
                width, ...
                "width", ...
                "TestRectangle:InvalidWidth");

            Shape.validatePositiveScalar( ...
                height, ...
                "height", ...
                "TestRectangle:InvalidHeight");

            obj.Width  = width;
            obj.Height = height;
        end

        function a = area(obj)
            %AREA
            %
            % Area of a rectangle after applying the inherited scale factor.
            %
            % If ScaleFactor = s, then:
            %   effective width  = Width  * s
            %   effective height = Height * s
            %   area             = Width * Height * s^2

            effectiveWidth  = obj.Width  * obj.ScaleFactor;
            effectiveHeight = obj.Height * obj.ScaleFactor;

            a = effectiveWidth * effectiveHeight;
        end

        function p = perimeter(obj)
            %PERIMETER
            %
            % Perimeter after applying the inherited scale factor.

            effectiveWidth  = obj.Width  * obj.ScaleFactor;
            effectiveHeight = obj.Height * obj.ScaleFactor;

            p = 2 * (effectiveWidth + effectiveHeight);
        end
    end

end
