clear;

T_data_extraction = readtable('../data/data.xlsx','Sheet','data_extraction_form');

unique_ID_count = length(unique(rmmissing(T_data_extraction.id_eppi_reviewer)));

num_meta_analyses = sum(T_data_extraction.ma_total_num, "omitnan");

plot_colour = '#4b8ac4';

fig_size_x = 10;
fig_size_y = 10;

section_labels_x = [0.062, 0.5];
section_labels_y = [0.96, 0.48];
section_labels_fontsize = 15;

axis_font_size = 12;


%% sleep quality assessments

sleep_qual = string(T_data_extraction.o_sq_broad);

sleep_qual_unique = unique(sleep_qual);

sleep_qual_counts = zeros(length(sleep_qual_unique), 1);

for i = 1 : length(sleep_qual_unique)
    sleep_qual_to_count = sleep_qual_unique(i);
    sleep_qual_counts(i) = sum(strcmp(sleep_qual_to_count, sleep_qual));
end

[~,b] = sort(sleep_qual_counts, 'ascend');

sleep_qual_counts = sleep_qual_counts(b);

sleep_qual_counts_pct = (sleep_qual_counts/num_meta_analyses) * 100;

sleep_qual_unique = sleep_qual_unique(b);

qual_other_idx = strcmp(sleep_qual_unique, "Other");
qual_other_txt = sleep_qual_unique(qual_other_idx);
qual_other_num = sleep_qual_counts_pct(qual_other_idx);

sleep_qual_unique(qual_other_idx) = [];
sleep_qual_counts_pct(qual_other_idx) =[];

sleep_qual_unique = [qual_other_txt; sleep_qual_unique];
sleep_qual_counts_pct = cat(1, qual_other_num, sleep_qual_counts_pct);

sleep_qual_names = sleep_qual_unique;
sleep_qual_names = strrep(sleep_qual_names, "sleep quantity", "Quantity");
sleep_qual_names = strrep(sleep_qual_names, "sleep initiation", "Initiation");
sleep_qual_names = strrep(sleep_qual_names, "sleep maintenance", "Maintenance");
sleep_qual_names = strrep(sleep_qual_names, "sleep quality", "Quality");
sleep_qual_names = strrep(sleep_qual_names, "refreshment upon awakening", "Refreshment");


%% sleep quality assessment measures

sleep_qual_measure = T_data_extraction.o_sq_measurement_std;

sleep_qual_measure = multiple_entries_to_vector(sleep_qual_measure);

sleep_qual_measure_unique = unique(sleep_qual_measure);

sleep_qual_measure_counts = zeros(length(sleep_qual_measure_unique), 1);

for i = 1 : length(sleep_qual_measure_unique)
    sleep_qual_measure_to_count = sleep_qual_measure_unique(i);
    sleep_qual_measure_counts(i) = sum(strcmp(sleep_qual_measure_to_count, sleep_qual_measure));
end

[~,b] = sort(sleep_qual_measure_counts, 'ascend');

sleep_qual_measure_counts = sleep_qual_measure_counts(b);

sleep_qual_measure_counts_pct = sleep_qual_measure_counts / max(sleep_qual_measure_counts);

sleep_qual_measure_unique = sleep_qual_measure_unique(b);

sleep_qual_measure_unique = strrep(sleep_qual_measure_unique, "index finger switch depression method", "IFWDM");
sleep_qual_measure_unique = strrep(sleep_qual_measure_unique, "nurse observation", "Nurse observation");
sleep_qual_measure_unique = strrep(sleep_qual_measure_unique, "parent report", "Parent report");
sleep_qual_measure_unique = strrep(sleep_qual_measure_unique, "muscle relaxation monitoring", "MRM");
sleep_qual_measure_unique = strrep(sleep_qual_measure_unique, "measurement of endogenous melatonin", "Endogenous Mel");
sleep_qual_measure_unique = strrep(sleep_qual_measure_unique, "self report", "Self-report");
sleep_qual_measure_unique = strrep(sleep_qual_measure_unique, "questionnaire", "Questionnaire");
sleep_qual_measure_unique = strrep(sleep_qual_measure_unique, "polysomnography", "Polysomnography");
sleep_qual_measure_unique = strrep(sleep_qual_measure_unique, "sleep diary", "Sleep diary");
sleep_qual_measure_unique = strrep(sleep_qual_measure_unique, "actigraphy", "Actigraphy");
sleep_qual_measure_unique = strrep(sleep_qual_measure_unique, "EEG", "EEG");
sleep_qual_measure_unique = strrep(sleep_qual_measure_unique, "VAS", "VAS");
sleep_qual_measure_unique = strrep(sleep_qual_measure_unique, "BIS", "BIS");


%% age

age = rmmissing(T_data_extraction.p_age_broad2);

age_unique = unique(age);

age_counts = zeros(length(age_unique), 1);

for i = 1 : length(age_unique)
    age_to_count = age_unique(i);
    age_counts(i) = sum(strcmp(age_to_count, age));
end

[~,b] = sort(age_counts, 'ascend');

age_counts = age_counts(b);

age_counts_pct = (age_counts/num_meta_analyses) * 100;

age_unique = age_unique(b);


%% figure 3

figure;

set(gcf,...
    'Units', 'Inches', ...
    'Position', [0, 0, fig_size_x, fig_size_y], ...
    'PaperPositionMode', 'auto');

subplot(2,2,1)
barh(sleep_qual_names, sleep_qual_counts_pct, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel("Percent of Meta-analyses")
ax = gca;
ax.FontSize = axis_font_size;

subplot(2,2,2)
barh(sleep_qual_measure_unique, sleep_qual_measure_counts_pct, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel("Proportion")
ax = gca;
ax.FontSize = axis_font_size;

subplot(2,2,3)
barh(age_unique, age_counts_pct, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
set(gca,'TickLabelInterpreter','none')
xlabel("Percent of Meta-analyses")
ax = gca;
ax.FontSize = axis_font_size;

a = annotation('textbox', [section_labels_x(1), section_labels_y(1), 0, 0], 'string', 'a.');
a.FontSize = section_labels_fontsize;

a = annotation('textbox', [section_labels_x(2), section_labels_y(1), 0, 0], 'string', 'b.');
a.FontSize = section_labels_fontsize;

a = annotation('textbox', [section_labels_x(1), section_labels_y(2), 0, 0], 'string', 'c.');
a.FontSize = section_labels_fontsize;

a = annotation('textbox', [section_labels_x(2), section_labels_y(2), 0, 0], 'string', 'd.');
a.FontSize = section_labels_fontsize;

exportgraphics(gcf,'../results/figure_3.pdf')