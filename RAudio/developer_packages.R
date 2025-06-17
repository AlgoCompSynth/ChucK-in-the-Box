#! /usr/bin/env Rscript

# tools I use for R package development / documentation
# see https://r-pkgs.org/

# detonate on first uninstallable
options(warn=2)
already_installed <- rownames(installed.packages())
required_packages <- c(
  "data.table",
  "devtools",
  "distill",
  "quarto",
  "reticulate",
  "tinytex"
)
to_install <- setdiff(required_packages, already_installed)
cat("\nInstalling:\n")
print(to_install)
install.packages(to_install, quiet = TRUE, repos = "https://cloud.r-project.org/")
warnings()
cat("\nInstalling TinyTeX\n")
tinytex::install_tinytex(force = TRUE)
cat("\nInstalling rextendr\n")
remotes::install_github("extendr/rextendr")
