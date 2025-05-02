clear;

T = readtable('../data/data.xlsx','Sheet','data_extraction_form');

idx_inactive = strcmp(string(T.c_broad), "Inactive");

T = T(idx_inactive,:);

plot_colour = '#4b8ac4';

Direction = T.r_direction;

SleepQuality = T.o_sq_broad;
Dose = T.i_dose_broad;
Age = T.p_age_broad;
Condition = T.p_condition_broad;

T2 = table(Direction, SleepQuality, Dose, Age, Condition);

x = ["Positive", "Negative", "Unclear"];

fig_size_x = 14;
fig_size_y = 12;

section_labels_x = 0.062;
section_labels_y = [0.95, 0.73, 0.51, 0.29];
section_labels_fontsize = 15;

axis_font_size = 12;

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


%% condition

var = 'Condition';

% child_neurodev
val = 'child_neurodev';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
condition_child_neurodev_y = [pos, neg, unc];

% adult_primary
val = 'adult_primary';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
condition_adult_primary_y = [pos, neg, unc];

% elderly_dementia
val = 'elderly_dementia';
pos = sum(sum([strcmp(T2.Direction, 'Favours melatonin'), strcmp(T2.(var), val)], 2) == 2);
neg = sum(sum([strcmp(T2.Direction, 'Favours control/comparator'), strcmp(T2.(var), val)], 2) == 2);
unc = sum(sum([strcmp(T2.Direction, 'Unclear'), strcmp(T2.(var), val)], 2) == 2);
condition_elderly_dementia_y = [pos, neg, unc];

neurodev = condition_child_neurodev_y([1,2])';
primary = condition_adult_primary_y([1,2])';
dementia = condition_elderly_dementia_y([1,2])';
table_condition = table(neurodev, primary, dementia);
table_condition.Properties.RowNames = ["positive"; "negative"];


%%

writetable(table_sleep_quality,'../results/efficacy_tables.xlsx','Sheet','sleep_quality',"WriteRowNames",true)
writetable(table_dose,'../results/efficacy_tables.xlsx','Sheet','dose',"WriteRowNames",true)
writetable(table_age,'../results/efficacy_tables.xlsx','Sheet','age',"WriteRowNames",true)
writetable(table_condition,'../results/efficacy_tables.xlsx','Sheet','condition',"WriteRowNames",true)


%% make figure

figure;

set(gcf,...
    'Units', 'Inches', ...
    'Position', [0, 0, fig_size_x, fig_size_y], ...
    'PaperPositionMode', 'auto');

% sleep quality

subplot(4,3,1)
bar(x, sq_quantity_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Sleep quantity')
ylabel('Meta-analyses (count)')
ax = gca;
ax.FontSize = axis_font_size;

subplot(4,3,2)
bar(x, sq_initiation_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Sleep initiation')
ax = gca;
ax.FontSize = axis_font_size;

subplot(4,3,3)
bar(x, sq_maintenance_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Sleep maintenance')
ax = gca;
ax.FontSize = axis_font_size;

% dose

subplot(4,3,4)
bar(x, dose_low_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Low (0.1-3mg)')
ylabel('Meta-analyses (count)')
ax = gca;
ax.FontSize = axis_font_size;

subplot(4,3,5)
bar(x, dose_medium_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Medium (3-5mg)')
ax = gca;
ax.FontSize = axis_font_size;

subplot(4,3,6)
bar(x, dose_high_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('High (5mg and higher)')
ax = gca;
ax.FontSize = axis_font_size;

% age

subplot(4,3,7)
bar(x, age_children_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Children (0-18 years)')
ylabel('Meta-analyses (count)')
ax = gca;
ax.FontSize = axis_font_size;

subplot(4,3,8)
bar(x, age_adults_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Adults (>18 years)')
ax = gca;
ax.FontSize = axis_font_size;

subplot(4,3,9)
bar(x, age_elderly_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Elderly (>65 years)')
ax = gca;
ax.FontSize = axis_font_size;

% condition

subplot(4,3,10)
bar(x, condition_child_neurodev_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Neurodevelopmental disorders (children)')
ylabel('Meta-analyses (count)')
ax = gca;
ax.FontSize = axis_font_size;

subplot(4,3,11)
bar(x, condition_adult_primary_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Primary sleep disorders (adults)')
ax = gca;
ax.FontSize = axis_font_size;

subplot(4,3,12)
bar(x, condition_elderly_dementia_y, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel('Dementia (elderly)')
ax = gca;
ax.FontSize = axis_font_size;

a = annotation('textbox', [section_labels_x(1), section_labels_y(1), 0, 0], 'string', 'a.');
a.FontSize = section_labels_fontsize;

a = annotation('textbox', [section_labels_x(1), section_labels_y(2), 0, 0], 'string', 'b.');
a.FontSize = section_labels_fontsize;

a = annotation('textbox', [section_labels_x(1), section_labels_y(3), 0, 0], 'string', 'c.');
a.FontSize = section_labels_fontsize;

a = annotation('textbox', [section_labels_x(1), section_labels_y(4), 0, 0], 'string', 'd.');
a.FontSize = section_labels_fontsize;

exportgraphics(gcf,'../results/figure_4.pdf')

