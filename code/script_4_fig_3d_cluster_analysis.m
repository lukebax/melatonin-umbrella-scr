clear;

T_citation_matrix = readtable('../data/data.xlsx','Sheet','citation_matrix');


%% citation matrix cluster analysis

T_citation_matrix.STUDYID = [];

variable_names = T_citation_matrix.Properties.VariableNames;
data = table2array(T_citation_matrix);
num_observations = size(data,1);
num_variables = size(data,2);

data_zscore = zscore(data);

correlationMatrix = corr(data_zscore, 'Type', 'Pearson');

idx = ismissing(correlationMatrix);
correlationMatrix(idx) = 0;

correlationMatrix_maxValue = max(max(abs(tril(correlationMatrix, -1))));

correlationMatrix_correlationDistancesMatrix = 1 - correlationMatrix;

correlationMatrix_euclideanDistancesMatrix = sqrt(2 * (num_observations - 1) * correlationMatrix_correlationDistancesMatrix);

iden_mat = eye(size(correlationMatrix_euclideanDistancesMatrix, 1));
iden_mat = iden_mat < 1;

correlationMatrix_euclideanDistancesMatrix = correlationMatrix_euclideanDistancesMatrix .* iden_mat;

ccorrelationMatrix_euclideanDistancesVector = squareform(correlationMatrix_euclideanDistancesMatrix);

% ccorrelationMatrix_euclideanDistancesVector = pdist(data_zscore', 'euclidean');

hierarchical_cluster_tree = linkage(ccorrelationMatrix_euclideanDistancesVector, 'ward');


% general plot variables

dendrogram_height=0.8;

correlationMatrixPlot_height = 0.7;

correlationMatrixPlot_width = 0.5 / (num_variables + 1);

overall_fig_size_x = 7;

overall_fig_size_y = 7.5;


figure('position',[10 10 1000 500]);


% dendrogram

subplot('position',[0 dendrogram_height 0.91 1-dendrogram_height]);

cluster_colour_threshold = 0.8 * max(hierarchical_cluster_tree(:,3));

colour_threshold = 'default';
[handles_to_lines, ~, variable_order] = dendrogram(hierarchical_cluster_tree, 0, 'colorthreshold', cluster_colour_threshold, ShowCut = true);
set(handles_to_lines, 'LineWidth', 3);
ax = gca;
ax.YTick = [];
ax.YColor = 'none';
ax.XRuler.Axle.Visible = 'off';
ax.XTickLabel = variable_names(variable_order);

% correlation matrix

subplot('position',[correlationMatrixPlot_width 0 1-2*correlationMatrixPlot_width correlationMatrixPlot_height-0.01]);

correlationMatrix_clusteredForPlotting = abs(correlationMatrix);
correlationMatrix_clusteredForPlotting = correlationMatrix_clusteredForPlotting(variable_order, variable_order);
correlationMatrix_clusteredForPlotting(eye(length(correlationMatrix_clusteredForPlotting))>0) = Inf; % set diagonal to infinity for nicer plot

colormap('sky');
colourmapHandle = colormap;
colourmapHandle(end,:) = [.8 .8 .8];
colormap(colourmapHandle);

heatmap_colorRange = [0, 1.01];


imagesc(correlationMatrix_clusteredForPlotting, heatmap_colorRange);

c = colorbar('eastoutside');
c = colorbar;
c.Label.String = 'Pearson correlation (absolute value)';

axis off;
daspect('auto');
set(gcf,...
    'Units', 'Inches', ...
    'Position', [0, 0, overall_fig_size_x, overall_fig_size_y], ...
    'PaperPositionMode', 'auto');

exportgraphics(gcf, '../results/figure_3d_cluster_analysis.pdf')
