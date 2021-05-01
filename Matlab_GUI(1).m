classdef appim < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure            matlab.ui.Figure
        UIAxes              matlab.ui.control.UIAxes
        UIAxes2             matlab.ui.control.UIAxes
        SelectimageButton   matlab.ui.control.Button
        processimageButton  matlab.ui.control.Button
        UIAxes3             matlab.ui.control.UIAxes
        B2WButton           matlab.ui.control.Button
    end

    methods (Access = private)

        % Button pushed function: SelectimageButton
        function SelectimageButtonPushed(app, event)
            global a;
            [filename, pathname] = uigetfile('*.*', 'Pick an image');
            filename=strcat(pathname,filename);
            a=imread(filename);
            imshow(a,'Parent',app.UIAxes);
        end

        % Button pushed function: processimageButton
        function processimageButtonPushed(app, event)
            global a;
            j=a;
            j=histeq(a);
            imshow(j,'Parent',app.UIAxes2);
        end

        % Button pushed function: B2WButton
        function B2WButtonPushed(app, event)
            global a;
            k=a;
            k=rgb2gray(a);
            imshow(k,'Parent',app.UIAxes3);
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'UI Figure';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'original ')
            app.UIAxes.Position = [1 300 224 131];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.UIFigure);
            title(app.UIAxes2, 'after')
            app.UIAxes2.Position = [214 300 214 131];

            % Create SelectimageButton
            app.SelectimageButton = uibutton(app.UIFigure, 'push');
            app.SelectimageButton.ButtonPushedFcn = createCallbackFcn(app, @SelectimageButtonPushed, true);
            app.SelectimageButton.Position = [37 138 100 22];
            app.SelectimageButton.Text = 'Select image';

            % Create processimageButton
            app.processimageButton = uibutton(app.UIFigure, 'push');
            app.processimageButton.ButtonPushedFcn = createCallbackFcn(app, @processimageButtonPushed, true);
            app.processimageButton.Position = [271 146 100 22];
            app.processimageButton.Text = 'process image';

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.UIFigure);
            title(app.UIAxes3, 'b2w')
            app.UIAxes3.Position = [427 294 225 137];

            % Create B2WButton
            app.B2WButton = uibutton(app.UIFigure, 'push');
            app.B2WButton.ButtonPushedFcn = createCallbackFcn(app, @B2WButtonPushed, true);
            app.B2WButton.Position = [490 146 100 22];
            app.B2WButton.Text = 'B2W';
        end
    end

    methods (Access = public)

        % Construct app
        function app = appim

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end