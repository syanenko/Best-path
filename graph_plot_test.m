app.na = 100

s = randi(app.na, app.na * 5, 1);
t = randi(app.na, app.na * 5, 1);
app.g = digraph(s, t, s, 'omitselfloops');

app.g.Edges.LWidths = 4 * app.g.Edges.Weight / max(app.g.Edges.Weight);
app.g.Nodes.NodeColors = indegree(app.g);

app.p = plot(app.g,'EdgeLabel', app.g.Edges.Weight)
app.p.NodeCData = app.g.Nodes.NodeColors;
app.p.MarkerSize = 7;
app.p.EdgeColor = [0.5 0.5 0.5];
app.p.LineWidth = app.g.Edges.LWidths;
