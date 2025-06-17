#! /usr/bin/env Rscript

# reference 
#@book{sueur2018sound,
#  title={Sound analysis and synthesis with R},
#  author={Sueur, J{\'e}r{\^o}me and others},
#  year={2018},
#  publisher={Springer}
#}

# detonate on first uninstallable
options(warn=2)
already_installed <- rownames(installed.packages())
required_packages <- c(
  "audio",
  "fluidsynth",
  "fractional",
  "gm",
  "monitoR",
  "music",
  "NatureSounds",
  "numbers",
  "phonTools",
  "seewave",
  "signal",
  "soundecology",
  "soundgen",
  "tuneR",
  "warbleR"
)
to_install <- setdiff(required_packages, already_installed)
cat("\nInstalling:\n")
print(to_install)
install.packages(to_install, quiet = TRUE, repos = "https://cloud.r-project.org/")
warnings()
remotes::install_github("AlgoCompSynth/consonaR", dependencies=TRUE)
remotes::install_github("AlgoCompSynth/eikosany", dependencies=TRUE)
