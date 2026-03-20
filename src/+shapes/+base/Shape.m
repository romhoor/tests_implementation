classdef (Abstract) Shape
    %SHAPE Abstract base class for 2-D shapes in the shapes package.
    %
    % This package version is separate from the earlier root-level demo.
    % It is intended for a more complete unit-test suite.

    properties (Abstract)
        %NAME Human-readable shape name.
        Name (1,1) string
    end

    properties (SetAccess = protected)
        %SCALEFACTOR Multiplicative scale applied to geometric dimensions.
        ScaleFactor (1,1) double = 1
    end

    methods (Abstract)
        %AREA Return the scaled area of the shape.
        a = area(obj)

        %PERIMETER Return the scaled perimeter of the shape.
        p = perimeter(obj)
    end

    methods
        function obj = scaleBy(obj, factor)
            %SCALEBY Return a copy of the shape scaled by factor.
            shapes.base.Shape.validatePositiveScalar( ...
                factor, ...
                "factor", ...
                "shapes:Shape:InvalidScaleFactor");

            obj.ScaleFactor = obj.ScaleFactor * factor;
        end

        function obj = resetScale(obj)
            %RESETSCALE Return a copy with identity scale.
            obj.ScaleFactor = 1;
        end

        function tf = isAreaAtLeast(obj, threshold)
            %ISAREAATLEAST Compare the scaled area against threshold.
            shapes.base.Shape.validateNonnegativeScalar( ...
                threshold, ...
                "threshold", ...
                "shapes:Shape:InvalidAreaThreshold");

            tf = obj.area() >= threshold;
        end

        function txt = summary(obj)
            %SUMMARY Return a stable textual summary of current geometry.
            txt = string(sprintf( ...
                "Shape=%s | ScaleFactor=%.15g | Area=%.15g | Perimeter=%.15g", ...
                char(obj.Name), ...
                obj.ScaleFactor, ...
                obj.area(), ...
                obj.perimeter()));
        end
    end

    methods (Static, Access = protected)
        function validatePositiveScalar(value, valueName, errorId)
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
