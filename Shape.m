classdef (Abstract) Shape
    %SHAPE
    %
    % Abstract superclass for simple 2-D shapes.
    %
    % Why abstract?
    %   - We do NOT want users to instantiate the generic concept directly.
    %   - We DO want every concrete subclass to implement a common contract.
    %
    % What is the contract here?
    %   1) every subclass must provide a Name as a scalar string
    %   2) every subclass must implement area()
    %   3) every subclass must implement perimeter()
    %
    % What is shared here?
    %   - a scale factor
    %   - methods that operate through the abstract API:
    %       scaleBy()
    %       isAreaAtLeast()
    %       summary()
    %
    % Important design note:
    %   This is a VALUE class example.
    %   Therefore, methods that modify object state return the updated object.
    %
    %   Example:
    %       s = TestRectangle(2, 3);
    %       s = s.scaleBy(2);   % reassign the returned object
    %
    %   If later you want in-place mutation semantics, we can convert this
    %   hierarchy to inherit from handle.

    properties (Abstract)
        %NAME
        %
        % Abstract property:
        % every concrete subclass must provide it.
        %
        % The validation is declared here in the abstract superclass.
        % That keeps the contract explicit in one place.
        %
        % MATLAB does not allow the concrete subclass implementation of an
        % inherited abstract property to repeat size/validation syntax, so
        % subclasses supply the value, not a second validation declaration.
        Name (1,1) string
    end

    properties (SetAccess = protected)
        %SCALEFACTOR
        %
        % Shared concrete state owned by the superclass.
        %
        % Protected write access means:
        %   - code outside the object cannot assign to it directly
        %   - superclass/subclasses can update it
        %
        % Start from identity scale.
        ScaleFactor (1,1) double = 1
    end

    methods (Abstract)
        %AREA
        %
        % Return the current area of the shape.
        %
        % The actual formula depends on the concrete subclass.
        a = area(obj)

        %PERIMETER
        %
        % Return the current perimeter of the shape.
        %
        % Again, concrete subclasses decide how to compute it.
        p = perimeter(obj)
    end

    methods
        function obj = scaleBy(obj, factor)
            %SCALEBY
            %
            % Shared concrete method.
            %
            % This does not know anything about a rectangle, circle, etc.
            % It only updates the common scale factor.
            %
            % Because this is a VALUE class, we return obj.

            Shape.validatePositiveScalar( ...
                factor, ...
                "factor", ...
                "Shape:InvalidScaleFactor");

            obj.ScaleFactor = obj.ScaleFactor * factor;
        end

        function obj = resetScale(obj)
            %RESETSCALE
            %
            % Restore identity scale and return the updated value object.

            obj.ScaleFactor = 1;
        end

        function tf = isAreaAtLeast(obj, threshold)
            %ISAREAATLEAST
            %
            % Example of a "template-style" shared method:
            %   - it is implemented once in the superclass
            %   - it depends on an abstract method implemented by subclasses
            %
            % This is exactly the kind of method that is very interesting to
            % test in an abstract hierarchy.

            Shape.validateNonnegativeScalar( ...
                threshold, ...
                "threshold", ...
                "Shape:InvalidAreaThreshold");

            tf = obj.area() >= threshold;
        end

        function txt = summary(obj)
            %SUMMARY
            %
            % Another concrete inherited method.
            %
            % It uses:
            %   - shared superclass state     -> ScaleFactor
            %   - subclass-provided property  -> Name
            %   - subclass-provided methods   -> area(), perimeter()
            %
            % So it is a nice integration point between abstract and concrete
            % parts of the hierarchy.

            txt = string(sprintf( ...
                "Shape=%s | ScaleFactor=%.6g | Area=%.6g | Perimeter=%.6g", ...
                char(string(obj.Name)), ...
                obj.ScaleFactor, ...
                obj.area(), ...
                obj.perimeter()));
        end
    end

    methods (Static, Access = protected)
        function validatePositiveScalar(value, valueName, errorId)
            %VALIDATEPOSITIVESCALAR
            %
            % Small reusable validation helper.
            %
            % Kept in the superclass because several methods/classes in the
            % hierarchy may need the same check.

            isOk = isnumeric(value)  && ...
                   isreal(value)     && ...
                   isscalar(value)   && ...
                   isfinite(value)   && ...
                   (value > 0);

            if ~isOk
                error(errorId, "%s must be a finite positive scalar.", valueName);
            end
        end

        function validateNonnegativeScalar(value, valueName, errorId)
            %VALIDATENONNEGATIVESCALAR
            %
            % Same idea as above, but allowing zero.

            isOk = isnumeric(value)  && ...
                   isreal(value)     && ...
                   isscalar(value)   && ...
                   isfinite(value)   && ...
                   (value >= 0);

            if ~isOk
                error(errorId, "%s must be a finite nonnegative scalar.", valueName);
            end
        end
    end
end
