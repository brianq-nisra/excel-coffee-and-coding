# Use a fixed CRAN mirror for any dependencies that need to be installed.
options(
  repos = c(
    CRAN = "https://cran.rstudio.com/"
  )
)

# Ensure the remotes and languageserver packages are
# available so Dashboard BuildR can be installed directly from GitHub.

pkgs <- c(
  "here",
  "openxlsx",
  "dplyr",
  "readr",
  "english"
)

for (pkg in pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}

# Source functions
for (file in list.files("functions", full.names = TRUE)) {
  source(file)
}


# Date of publication
pub_date_words_dmy <- "20 October 2026"

