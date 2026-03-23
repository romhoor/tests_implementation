% Rectangle is a concrete subclass of Shape.
% It stores unscaled width and height values and uses the inherited
% ScaleFactor from Shape when computing area and perimeter.
classdef Rectangle < Shape
    properties (Constant, Access = protected)
        % Constant identifier for the Rectangle shape type.
        shape_id = uint8(ShapeIDEnum.SHAPE_ID_RECTANGLE)
    end

    properties (Access = protected)
        % Width stored in this specific Rectangle object.
        % This is the base width before scaling is applied.
        Width (1,1) double = 1

        % Height stored in this specific Rectangle object.
        % This is the base height before scaling is applied.
        Height (1,1) double = 1
    end

    methods
        % Constructor.
        % Supported constructor calls are:
        % Rectangle()                        -> Width = 1, Height = 1, ScaleFactor = 1
        % Rectangle(width, height)          -> Width = width, Height = height, ScaleFactor = 1
        % Rectangle(width, height, scaleFactor)
        %                                  -> Width = width, Height = height, ScaleFactor = scaleFactor
        %
        % The first two inputs always refer to Rectangle-specific
        % properties. The optional third input is forwarded to Shape as
        % the scale factor.
        function obj = Rectangle(varargin)
            if nargin > 3
                error('Rectangle:TooManyInputs', ...
                    'Rectangle accepts at most three inputs: width, height, and scaleFactor.');
            end

            if nargin < 1
                width = 1;
            else
                width = varargin{1};
            end

            if nargin < 2
                height = 1;
            else
                height = varargin{2};
            end

            % Forward only the optional third input to Shape.
            obj@Shape(varargin{3:end});

            obj.Width = width;
            obj.Height = height;
        end

        % Setter method for Width.
        % Because Rectangle inherits from handle through Shape, this
        % method modifies the existing object directly.
        function setWidth(obj, width)
            obj.Width = width;
        end

        % Setter method for Height.
        % Because Rectangle inherits from handle through Shape, this
        % method modifies the existing object directly.
        function setHeight(obj, height)
            obj.Height = height;
        end

        % Getter method for Width.
        % Returns the current unscaled width stored in this object.
        function width = getWidth(obj)
            width = obj.Width;
        end

        % Getter method for Height.
        % Returns the current unscaled height stored in this object.
        function height = getHeight(obj)
            height = obj.Height;
        end

    end

    methods (Access = protected)
        % Compute the rectangle area before the Shape-level validation step.
        function a = computeArea(obj)
            effectiveWidth = obj.Width * obj.ScaleFactor;
            effectiveHeight = obj.Height * obj.ScaleFactor;
            a = effectiveWidth * effectiveHeight;
        end

        % Compute the rectangle perimeter before the Shape-level validation step.
        function p = computePerimeter(obj)
            effectiveWidth = obj.Width * obj.ScaleFactor;
            effectiveHeight = obj.Height * obj.ScaleFactor;
            p = 2 * (effectiveWidth + effectiveHeight);
        end
    end
end
