clear;

T = readtable('../data/data.xlsx','Sheet','data_extraction_form');

idx_inactive = strcmp(string(T.c_broad), "Inactive");

T = T(idx_inactive,:);

Direction = T.r_direction;

SleepQuality = T.o_sq_broad;
Dose = T.i_dose_broad;
Age = T.p_age_broad;

T2 = table(Direction, SleepQuality, Dose, Age);

%% plotting variable

plot_colour = '#4b8ac4';

x = ["Positive", "Negative", "Unclear"];

fig_size_x = 14;
fig_size_y = 9;

section_labels_x = 0.062;
section_labels_y = [0.95, 0.65, 0.35];
section_labels_fontsize = 15;

axis_font_size = 12;

%% overall

pos = sum(strcmp(T2.Direction, 'Favours melatonin'));
neg = sum(strcmp(T2.Direction, 'Favours control/comparator'));

table_overall = table([pos; neg], 'VariableNames', {'Count'});
table_overall.Properties.RowNames = {'positive'; 'negative'};

%% sleep quality

var = 'SleepQuality';

% sleep quantity
val = 'sleep quantity';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
sq_quantity_y = [pos, neg, unc];

% sleep initiation
val = 'sleep initiation';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
sq_initiation_y = [pos, neg, unc];

% sleep maintenance
val = 'sleep maintenance';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
sq_maintenance_y = [pos, neg, unc];

quantity = sq_quantity_y([1,2])';
initiation = sq_initiation_y([1,2])';
maintenance = sq_maintenance_y([1,2])';
table_sleep_quality = table(quantity, initiation, maintenance);
table_sleep_quality.Properties.RowNames = ["positive"; "negative"];


%% dose

var = 'Dose';

% low
val = 'low';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
dose_low_y = [pos, neg, unc];

% medium
val = 'medium';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
dose_medium_y = [pos, neg, unc];

% high
val = 'high';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
dose_high_y = [pos, neg, unc];

low = dose_low_y([1,2])';
medium = dose_medium_y([1,2])';
high = dose_high_y([1,2])';
table_dose = table(low, medium, high);
table_dose.Properties.RowNames = ["positive"; "negative"];

%% age

var = 'Age';

% Children
val = 'Children';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
age_children_y = [pos, neg, unc];

% Adults
val = 'Adults';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
age_adults_y = [pos, neg, unc];

% Elderly
val = 'Elderly';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
age_elderly_y = [pos, neg, unc];

children = age_children_y([1,2])';
adults = age_adults_y([1,2])';
elderly = age_elderly_y([1,2])';
table_age = table(children, adults, elderly);
table_age.Properties.RowNames = ["positive"; "negative"];


%% export spreadsheet

writetable(table_overall,'../results/efficacy_tables.xlsx','Sheet','overall',"WriteRowNames",true)
writetable(table_sleep_quality,'../results/efficacy_tables.xlsx','Sheet','sleep_quality',"WriteRowNames",true)
writetable(table_dose,'../results/efficacy_tables.xlsx','Sheet','dose',"WriteRowNames",true)
writetable(table_age,'../results/efficacy_tables.xlsx','Sheet','age',"WriteRowNames",true)


%% make figure

figure;

set(gcf,...
    'Units', 'Inches', ...
    'Position', [0, 0, fig_size_x, fig_size_y], ...
    'PaperPositionMode', 'auto');

% sleep quality

subplot(3,3,1)
bar(x, sq_quantity_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Sleep Quantity')
ylabel('Meta-analyses (count)')
ax = gca;
ax.FontSize = axis_font_size;

subplot(3,3,2)
bar(x, sq_initiation_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Sleep Initiation')
ax = gca;
ax.FontSize = axis_font_size;

subplot(3,3,3)
bar(x, sq_maintenance_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Sleep Maintenance')
ax = gca;
ax.FontSize = axis_font_size;

% dose

subplot(3,3,4)
bar(x, dose_low_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Low (0.1-3mg)')
ylabel('Meta-analyses (count)')
ax = gca;
ax.FontSize = axis_font_size;

subplot(3,3,5)
bar(x, dose_medium_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Medium (3-5mg)')
ax = gca;
ax.FontSize = axis_font_size;

subplot(3,3,6)
bar(x, dose_high_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('High (5mg and higher)')
ax = gca;
ax.FontSize = axis_font_size;

% age

subplot(3,3,7)
bar(x, age_children_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Children (0-18 years)')
ylabel('Meta-analyses (count)')
ax = gca;
ax.FontSize = axis_font_size;

subplot(3,3,8)
bar(x, age_adults_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Adults (>18 years)')
ax = gca;
ax.FontSize = axis_font_size;

subplot(3,3,9)
bar(x, age_elderly_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Older adults (>65 years)')
ax = gca;
ax.FontSize = axis_font_size;

a = annotation('textbox', [section_labels_x(1), section_labels_y(1), 0, 0], 'string', 'a.');
a.FontSize = section_labels_fontsize;

a = annotation('textbox', [section_labels_x(1), section_labels_y(2), 0, 0], 'string', 'b.');
a.FontSize = section_labels_fontsize;

a = annotation('textbox', [section_labels_x(1), section_labels_y(3), 0, 0], 'string', 'c.');
a.FontSize = section_labels_fontsize;

exportgraphics(gcf,'../results/figure_4.pdf')

