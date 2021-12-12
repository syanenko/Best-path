classdef Best_path_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        GraphpresentationdemoUIFigure  matlab.ui.Figure
        Panel                          matlab.ui.container.Panel
        NodesamountSlider              matlab.ui.control.Slider
        NodesamountSliderLabel         matlab.ui.control.Label
        Panel_2                        matlab.ui.container.Panel
        ResetcolorsButton              matlab.ui.control.Button
        FindpathButton                 matlab.ui.control.Button
        RecreategraphButton            matlab.ui.control.Button
        BestpathindirectedgraphLabel   matlab.ui.control.Label
        UIAxes                         matlab.ui.control.UIAxes
    end

    
    properties (Access = public)
        h % Description
        g % Graph
        p % Plot
        na = 12; % Nodes amount
    end

    methods (Access = private)
        function bestPath(app)
            rng();
            b = randi(app.na, 1);
            e = randsample(setdiff(1:app.na, b), 1);
            sp = shortestpath(app.g, b, e);
            disp("Nodes: " + b + " " + e);
            disp(sp);
            disp("------------------------------------------------");
            app.p.EdgeColor = [0.5 0.5 0.5];
            highlight(app.p, sp,'EdgeColor', [1 0 0]);
        end
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            axis(app.UIAxes,'off')
            colorbar(app.UIAxes);
            createGraph3(app);
        end

        % Button pushed function: RecreategraphButton
        function createGraph3(app, event)
            s = randi(app.na, app.na * 3, 1);
            t = randi(app.na, app.na * 3, 1);
            app.g = digraph(s, t, s, 'omitselfloops');
            
            app.g.Edges.LWidths = 4 * app.g.Edges.Weight / max(app.g.Edges.Weight);
            app.g.Nodes.NodeColors = indegree(app.g);

            app.p = plot(app.UIAxes, app.g,'EdgeLabel', app.g.Edges.Weight)
            app.p.NodeCData = app.g.Nodes.NodeColors;
            app.p.MarkerSize = 7;
            app.p.ArrowSize = 12;
            app.p.EdgeColor = [0.5 0.5 0.5];
            app.p.LineWidth = app.g.Edges.LWidths;
        end

        % Button pushed function: FindpathButton
        function FindpathButtonPushed3(app, event)
            bestPath(app);
        end

        % Callback function
        function FindbestpathButtonPushed2(app, event)
            
        end

        % Button pushed function: ResetcolorsButton
        function ResetcolorsButtonPushed(app, event)
            app.g.Nodes.NodeColors = rand(app.na) * indegree(app.g);
            app.p.NodeCData = app.g.Nodes.NodeColors;
            app.p.EdgeColor = [0.5 0.5 0.5];
        end

        % Value changed function: NodesamountSlider
        function NodesamountSliderValueChanged(app, event)
            app.na = round(app.NodesamountSlider.Value);
            createGraph3(app);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create GraphpresentationdemoUIFigure and hide until all components are created
            app.GraphpresentationdemoUIFigure = uifigure('Visible', 'off');
            app.GraphpresentationdemoUIFigure.AutoResizeChildren = 'off';
            app.GraphpresentationdemoUIFigure.Color = [0.651 0.651 0.651];
            app.GraphpresentationdemoUIFigure.Position = [100 100 1008 646];
            app.GraphpresentationdemoUIFigure.Name = 'Graph presentation demo';
            app.GraphpresentationdemoUIFigure.Resize = 'off';

            % Create UIAxes
            app.UIAxes = uiaxes(app.GraphpresentationdemoUIFigure);
            ylabel(app.UIAxes, {''; ''})
            app.UIAxes.FontName = 'Arial';
            app.UIAxes.XTick = [];
            app.UIAxes.YTick = [];
            app.UIAxes.FontSize = 16;
            app.UIAxes.Clipping = 'off';
            app.UIAxes.Position = [19 22 823 572];

            % Create BestpathindirectedgraphLabel
            app.BestpathindirectedgraphLabel = uilabel(app.GraphpresentationdemoUIFigure);
            app.BestpathindirectedgraphLabel.HorizontalAlignment = 'center';
            app.BestpathindirectedgraphLabel.FontName = 'Arial';
            app.BestpathindirectedgraphLabel.FontSize = 20;
            app.BestpathindirectedgraphLabel.FontAngle = 'italic';
            app.BestpathindirectedgraphLabel.FontColor = [0.149 0.149 0.149];
            app.BestpathindirectedgraphLabel.Position = [283 606 247 24];
            app.BestpathindirectedgraphLabel.Text = 'Best path in directed graph';

            % Create Panel
            app.Panel = uipanel(app.GraphpresentationdemoUIFigure);
            app.Panel.AutoResizeChildren = 'off';
            app.Panel.TitlePosition = 'centertop';
            app.Panel.BackgroundColor = [0.651 0.651 0.651];
            app.Panel.Position = [851 22 143 572];

            % Create RecreategraphButton
            app.RecreategraphButton = uibutton(app.Panel, 'push');
            app.RecreategraphButton.ButtonPushedFcn = createCallbackFcn(app, @createGraph3, true);
            app.RecreategraphButton.BackgroundColor = [0.9412 0.851 0.4902];
            app.RecreategraphButton.FontSize = 14;
            app.RecreategraphButton.Position = [12 470 119 33];
            app.RecreategraphButton.Text = {'Recreate graph'; ''};

            % Create FindpathButton
            app.FindpathButton = uibutton(app.Panel, 'push');
            app.FindpathButton.ButtonPushedFcn = createCallbackFcn(app, @FindpathButtonPushed3, true);
            app.FindpathButton.BackgroundColor = [0.9294 0.7098 0.4902];
            app.FindpathButton.FontSize = 14;
            app.FindpathButton.Position = [11 521 119 33];
            app.FindpathButton.Text = 'Find path';

            % Create ResetcolorsButton
            app.ResetcolorsButton = uibutton(app.Panel, 'push');
            app.ResetcolorsButton.ButtonPushedFcn = createCallbackFcn(app, @ResetcolorsButtonPushed, true);
            app.ResetcolorsButton.BackgroundColor = [0.5098 0.8784 0.8784];
            app.ResetcolorsButton.FontSize = 14;
            app.ResetcolorsButton.Position = [12 416 119 33];
            app.ResetcolorsButton.Text = {'Reset colors'; ''};

            % Create Panel_2
            app.Panel_2 = uipanel(app.Panel);
            app.Panel_2.AutoResizeChildren = 'off';
            app.Panel_2.BackgroundColor = [0.7294 0.8784 0.651];
            app.Panel_2.Position = [17 15 109 369];

            % Create NodesamountSliderLabel
            app.NodesamountSliderLabel = uilabel(app.Panel);
            app.NodesamountSliderLabel.HorizontalAlignment = 'right';
            app.NodesamountSliderLabel.FontSize = 14;
            app.NodesamountSliderLabel.Position = [22 354 97 22];
            app.NodesamountSliderLabel.Text = {'Nodes amount'; ''};

            % Create NodesamountSlider
            app.NodesamountSlider = uislider(app.Panel);
            app.NodesamountSlider.Limits = [2 30];
            app.NodesamountSlider.Orientation = 'vertical';
            app.NodesamountSlider.ValueChangedFcn = createCallbackFcn(app, @NodesamountSliderValueChanged, true);
            app.NodesamountSlider.Position = [54 30 3 313];
            app.NodesamountSlider.Value = 10;

            % Show the figure after all components are created
            app.GraphpresentationdemoUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Best_path_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.GraphpresentationdemoUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.GraphpresentationdemoUIFigure)
        end
    end
end