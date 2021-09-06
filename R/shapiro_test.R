shapiro_test <- function(.data, var, group = NULL) {
  .data %>%
    dplyr::group_by(dplyr::across({{group}})) %>%
    dplyr::summarise(broom::tidy(shapiro.test({{var}})))
}
