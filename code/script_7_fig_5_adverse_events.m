clear;

T_data_extraction = readtable('../data/data.xlsx','Sheet','data_extraction_form');

unique_ID_count = length(unique(rmmissing(T_data_extraction.id_eppi_reviewer)));

plot_colour = '#4b8ac4';

fig_size_x = 15;
fig_size_y = 6;

section_labels_x = [0.04, 0.48];
section_labels_y = 0.96;
section_labels_fontsize = 15;

axis_font_size = 12;


%% adverse events

adverse_events = T_data_extraction.ae_events_std;

adverse_events = multiple_entries_to_vector(adverse_events);

adverse_events = strrep(adverse_events, "diarrhoea", "gastrointestinal problems");
adverse_events = strrep(adverse_events, "depression/mood changes", "mood changes");

adverse_events(strcmp(adverse_events, "not listed")) = [];
adverse_events(strcmp(adverse_events, "not recorded")) = [];

adverse_events_unique = unique(adverse_events);

adverse_events_counts = zeros(length(adverse_events_unique), 1);

for i = 1 : length(adverse_events_unique)
    adverse_event_to_count = adverse_events_unique(i);
    adverse_events_counts(i) = sum(strcmp(adverse_event_to_count, adverse_events));
end

[~,b] = sort(adverse_events_counts, 'ascend');

adverse_events_counts = adverse_events_counts(b);

adverse_events_counts_pct = (adverse_events_counts / unique_ID_count ) * 100;

adverse_events_unique = adverse_events_unique(b);


%% figure 3

figure;

set(gcf,...
    'Units', 'Inches', ...
    'Position', [0, 0, fig_size_x, fig_size_y], ...
    'PaperPositionMode', 'auto');

subplot(1,2,1)

barh(adverse_events_unique, adverse_events_counts, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel("Number of reviews")
ax = gca;
ax.FontSize = axis_font_size;

subplot(1,2,2)
barh(adverse_events_unique, adverse_events_counts_pct, 'EdgeColor', plot_colour, 'FaceColor', plot_colour)
xlabel("Percent of reviews")
xlim([0,100])
ax = gca;
ax.FontSize = axis_font_size;

a = annotation('textbox', [section_labels_x(1), section_labels_y, 0, 0], 'string', 'a.');
a.FontSize = section_labels_fontsize;

a = annotation('textbox', [section_labels_x(2), section_labels_y, 0, 0], 'string', 'b.');
a.FontSize = section_labels_fontsize;

exportgraphics(gcf,'../results/figure_5.pdf')