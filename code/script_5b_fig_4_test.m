clear;

T = readtable('../data/data.xlsx','Sheet','data_extraction_form');

plot_colour = '#4b8ac4';

Direction = T.r_direction;
Comparator = T.c_broad;

T2 = table(Direction, Comparator);

x = ["Positive", "Negative", "Unclear"];

fig_size_x = 14;
fig_size_y = 3;

section_labels_x = 0.062;
section_labels_y = [0.95, 0.73, 0.51, 0.29];
section_labels_fontsize = 15;

axis_font_size = 12;

%% sleep quality

var = 'Comparator';

% sleep quantity
val = 'Inactive';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
c_inactive_y = [pos, neg, unc];

% sleep initiation
val = 'Active';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
c_active_y = [pos, neg, unc];

% sleep maintenance
val = 'Both';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
c_both_y = [pos, neg, unc];

inactive = c_inactive_y([1,2])';
active = c_active_y([1,2])';
both = c_both_y([1,2])';
table_comparator = table(inactive, active, both);
table_comparator.Properties.RowNames = ["positive"; "negative"];


%

%% make figure

figure;

set(gcf,...
    'Units', 'Inches', ...
    'Position', [0, 0, fig_size_x, fig_size_y], ...
    'PaperPositionMode', 'auto');

% sleep quality

subplot(1,3,1)
bar(x, c_inactive_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Inactive')
ylabel('Meta-analyses (count)')
ax = gca;
ax.FontSize = axis_font_size;

subplot(1,3,2)
bar(x, c_active_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
yticks([0 : 1 : max(c_active_y)]);
xlabel('Active')
ax = gca;
ax.FontSize = axis_font_size;

subplot(1,3,3)
bar(x, c_both_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Both')
ax = gca;
ax.FontSize = axis_font_size;

exportgraphics(gcf,'../results/figure_4_test.pdf')

