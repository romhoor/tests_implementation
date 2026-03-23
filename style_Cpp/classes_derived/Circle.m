% Circle is a concrete subclass of Shape.
% It stores one unscaled radius and uses the inherited ScaleFactor from
% Shape when computing area and perimeter.
classdef Circle < Shape
    properties (Constant, Access = protected)
        % Constant identifier for the Circle shape type.
        shape_id = uint8(ShapeIDEnum.SHAPE_ID_CIRCLE)
    end

    properties (Access = protected)
        % Radius stored in this specific Circle object.
        % This is the base radius before scaling is applied.
        Radius (1,1) double = 1
    end

    methods
        % Constructor.
        % Supported constructor calls are:
        % Circle()                    -> Radius = 1, ScaleFactor = 1
        % Circle(radius)             -> Radius = radius, ScaleFactor = 1
        % Circle(radius, scaleFactor)-> Radius = radius, ScaleFactor = scaleFactor
        %
        % The first input always refers to the Circle-specific property
        % Radius. The optional second input is forwarded to Shape as the
        % scale factor.
        function obj = Circle(varargin)
            if nargin > 2
                error('Circle:TooManyInputs', ...
                    'Circle accepts at most two inputs: radius and scaleFactor.');
            end

            if nargin < 1
                radius = 1;
            else
                radius = varargin{1};
            end

            % Forward only the optional second input to Shape.
            obj@Shape(varargin{2:end});

            obj.Radius = radius;
        end

        % Setter method for Radius.
        % Because Circle inherits from handle through Shape, this method
        % modifies the existing object directly.
        function setRadius(obj, radius)
            obj.Radius = radius;
        end

        % Getter method for Radius.
        % Returns the current unscaled radius stored in this object.
        function radius = getRadius(obj)
            radius = obj.Radius;
        end

    end

    methods (Access = protected)
        % Compute the circle area before the Shape-level validation step.
        function a = computeArea(obj)
            effectiveRadius = obj.Radius * obj.ScaleFactor;
            a = pi * effectiveRadius^2;
        end

        % Compute the circle perimeter before the Shape-level validation step.
        function p = computePerimeter(obj)
            effectiveRadius = obj.Radius * obj.ScaleFactor;
            p = 2 * pi * effectiveRadius;
        end
    end
end
