clear;

T_data_extraction = readtable('../data/data.xlsx','Sheet','data_extraction_form');

if ~exist('../results/', 'dir')
    mkdir('../results/')
end

unique_ID_count = length(unique(rmmissing(T_data_extraction.id_eppi_reviewer)));

plot_colour = '#4b8ac4';

fig_size_x = 10;
fig_size_y = 10;

section_labels_x = [0.062, 0.5];
section_labels_y = [0.96, 0.48];
section_labels_fontsize = 15;

axis_font_size = 12;

%% publication year

years = T_data_extraction.pub_year;

years = rmmissing(years);

years_unique = unique(years);

min_year = min(years_unique);
max_year = max(years_unique);

all_years = (min_year : max_year)';

year_counts = all_years*0;

for i = 1 : length(all_years)
    year_to_count = all_years(i);
    year_counts(i) = sum(year_to_count == years);
end


%% Quality of reviews

qual_vars = ["pre_reg",...
    "num_db",...
    "full_search",...
    "screen_multiple",...
    "extraction_multiple",...
    "rob",...
    "pb_broad"];

qual_vars_long = ["Pre-registration",...
    "Databases",...
    "Full search",...
    "Screening",...
    "Data extraction",...
    "Risk of bias",...
    "Publication bias"];

X = T_data_extraction{:,qual_vars};

quality_counts = sum(X, 1, "omitnan");

[~,b] = sort(quality_counts, 'ascend');

quality_counts = quality_counts(b);

quality_counts_pct = (quality_counts/unique_ID_count) * 100;

qual_vars = qual_vars(b);
qual_vars_long = qual_vars_long(b);

% histogram
quality_counts2 = sum(X, 2);
quality_counts2(isnan(quality_counts2)) = [];

all_quality_counts2 = (0 : 7)';

quality_counts2_counts = all_quality_counts2*0;

for i = 1 : length(all_quality_counts2)
    qual_to_count = all_quality_counts2(i);
    quality_counts2_counts(i) = sum(qual_to_count == quality_counts2);
end


%% figure 2

figure;

set(gcf,...
    'Units', 'Inches', ...
    'Position', [0, 0, fig_size_x, fig_size_y], ...
    'PaperPositionMode', 'auto');

subplot(2,2,1)
bar(all_years, year_counts, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xticks(all_years);
ylabel("Number of Reviews")
ax = gca;
ax.FontSize = axis_font_size;

subplot(2,2,3)
bar(all_quality_counts2, quality_counts2_counts, 'EdgeColor', plot_colour, 'FaceColor', plot_colour, 'FaceAlpha', 1)
xlabel("Number of Systematic Review Criteria")
ylabel("Number of Reviews")
ax = gca;
ax.FontSize = axis_font_size;

subplot(2,2,4)
barh(quality_counts_pct, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
yticklabels(qual_vars_long)
xlabel("Percent of Reviews")
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

exportgraphics(gcf,'../results/figure_2.pdf')

