
reprex::reprex({
  library(tidyr)
  library(purrr)
  library(ggplot2)
  data  <- center_scale_data(log10(sim_adat))
  t_tbl <- data |>
    getAnalyteInfo() |>
    filter(Units == "RFU") |>     # option to filter out features
    select(AptName = feature, SeqId, TargetFullName, EntrezGeneSymbol, UniProt)

  t_tbl <- t_tbl |>
    mutate(
      t_stat  = map(feature, ~ as.formula(paste(.x, "~ class_response")) |>
                      t.test(data = data)),   # fit t-tests
      p_value = map_dbl(t_stat, "p.value"),          # pull out p-values
      fdr     = p.adjust(p.value, method = "BH"),    # FDR test correction
      RFUs    = map(feature, ~ data.frame(data[, c("class_response", .x)]))  # orig data
    ) |>
    arrange(p_value) |>           # Re-order by `p-value`
    mutate(rank = row_number())   # add ranks column

  target_map <- head(t_tbl, 9) |>              # mapping table
    select(feature, Target = TargetFullName)    # SeqId -> Target (& rename)

  plot_tbl <- log10(sim_adat) |>
    select(class_response, target_map$feature) |>         # top 9 analytes
    pivot_longer(cols = -class_response, names_to = "feature", values_to = "RFU") |>
    dplyr::left_join(target_map) |>
    # order factor levels by 't_tbl' rank to order plots below
    mutate(Target = factor(Target, levels = target_map$Target))
  plot_tbl

  plot_tbl |>
    ggplot(aes(x = class_response, y = RFU, fill = class_response)) +
    geom_boxplot(alpha = 0.5, outlier.shape = NA) +
    scale_fill_manual(values = c("#24135F", "#00A499")) +
    geom_jitter(shape = 16, width = 0.1, alpha = 0.5) +
    facet_wrap(~ Target) +
    ggtitle("Boxplots of Top 9 Analytes by t-test") +
    labs(y = "log10(RFU)") +
    NULL
})
