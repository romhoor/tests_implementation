% dummyShape is a minimal concrete subclass of Shape used only for tests.
% Its purpose is to instantiate the abstract base class indirectly.
% It is not meant to represent any real geometric object.
classdef dummyShape < Shape
    methods
        % Constructor.
        % This constructor does not define any default value itself.
        % It forwards all received inputs directly to the Shape
        % constructor, so the parent class alone controls the defaulting
        % behavior and input handling.
        function obj = dummyShape(varargin)
            % varargin always exists, even when no input arguments are
            % provided. That allows one direct superclass constructor call
            % without duplicating the default logic from Shape.
            obj@Shape(varargin{:});
        end

        % Implementation of the abstract area method.
        % A concrete subclass must define this method, even when the class
        % exists only for testing. The returned value is intentionally 0.
        function a = area(~)
            a = 0;
        end

        % Implementation of the abstract perimeter method.
        % A concrete subclass must define this method, even when the class
        % exists only for testing. The returned value is intentionally 0.
        function p = perimeter(~)
            p = 0;
        end
    end
end
