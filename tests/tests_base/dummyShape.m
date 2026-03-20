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

    end

    methods (Access = protected)
        % Implementation hook for the abstract area computation.
        % The returned value is intentionally 0 because this class exists
        % only to support testing of the Shape base class.
        function a = computeArea(~)
            a = 0;
        end

        % Implementation hook for the abstract perimeter computation.
        % The returned value is intentionally 0 because this class exists
        % only to support testing of the Shape base class.
        function p = computePerimeter(~)
            p = 0;
        end
    end
end
