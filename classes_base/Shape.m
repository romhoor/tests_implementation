% Shape is an abstract base class for geometric shapes.
% It defines shared data and a method contract for all subclasses.
% Shape inherits from handle, so Shape objects use reference semantics.
% That means methods can modify the same object instance in place.
classdef (Abstract) Shape < handle
    properties (Access = protected)
        % Scale factor stored in this specific Shape object instance.
        % Each Shape object has its own ScaleFactor value.
        % This property is not shared between different objects.
        ScaleFactor (1,1) double = 1
    end

    methods (Abstract)
        % Abstract method for area.
        % Every non-abstract class that inherits from Shape must provide
        % its own implementation of this method.
        % Compute the shape area.
        a = area(obj)
        
        % Abstract method for perimeter.
        % Every non-abstract class that inherits from Shape must provide
        % its own implementation of this method.
        % Compute the shape perimeter.
        p = perimeter(obj)
    end

    methods
        % Constructor.
        % Builds a Shape object and initializes its scale factor.
        % If no input argument is given, the scale factor defaults to 1.
        function obj = Shape(scaleFactor)
            % Default the scale factor to 1 when no value is provided.
            if nargin < 1
                scaleFactor = 1;
            end

            obj.ScaleFactor = scaleFactor;
        end

        % Setter method for ScaleFactor.
        % Because Shape is a handle class, this method modifies the
        % existing object itself and does not need to return obj.
        function setScaleFactor(obj, scaleFactor)
            % Update the stored scale factor.
            obj.ScaleFactor = scaleFactor;
        end

        % Getter method for ScaleFactor.
        % Returns the scale factor currently stored in this Shape object.
        function scaleFactor = getScaleFactor(obj)
            % Return the current scale factor.
            scaleFactor = obj.ScaleFactor;
        end
    end
end
