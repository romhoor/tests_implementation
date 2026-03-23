% Square is a concrete subclass of Shape.
% It stores one unscaled side length and uses the inherited ScaleFactor
% from Shape when computing area and perimeter.
classdef Square < Shape
    properties (Constant, Access = protected)
        % Constant identifier for the Square shape type.
        shape_id = uint8(ShapeIDEnum.SHAPE_ID_SQUARE)
    end

    properties (Access = protected)
        % Side length stored in this specific Square object.
        % This is the base geometric side length before scaling is applied.
        Side (1,1) double = 1
    end

    methods
        % Constructor.
        % Supported constructor calls are:
        % Square()                    -> Side = 1, ScaleFactor = 1
        % Square(side)               -> Side = side, ScaleFactor = 1
        % Square(side, scaleFactor)  -> Side = side, ScaleFactor = scaleFactor
        %
        % The first input always refers to the Square-specific property
        % Side. The optional second input is forwarded to Shape as the
        % scale factor.
        function obj = Square(varargin)
            if nargin > 2
                error('Square:TooManyInputs', ...
                    'Square accepts at most two inputs: side and scaleFactor.');
            end

            % When no side is provided, use the Square default side length.
            if nargin < 1
                side = 1;
            else
                side = varargin{1};
            end

            % Forward only the optional second input to Shape.
            % This keeps the default scale-factor behavior owned by Shape.
            obj@Shape(varargin{2:end});

            obj.Side = side;
        end

        % Setter method for Side.
        % Because Square inherits from handle through Shape, this method
        % modifies the existing object directly.
        function setSide(obj, side)
            obj.Side = side;
        end

        % Getter method for Side.
        % Returns the current unscaled side length stored in this object.
        function side = getSide(obj)
            side = obj.Side;
        end

    end

    methods (Access = protected)
        % Compute the square area before the Shape-level validation step.
        function a = computeArea(obj)
            effectiveSide = obj.Side * obj.ScaleFactor;
            a = effectiveSide^2;
        end

        % Compute the square perimeter before the Shape-level validation step.
        function p = computePerimeter(obj)
            effectiveSide = obj.Side * obj.ScaleFactor;
            p = 4 * effectiveSide;
        end
    end
end
