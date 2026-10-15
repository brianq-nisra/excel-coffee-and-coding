###############################################
# Excel tables template
# ---------------------------------------------
# Edit the sections with your own info e.g. Title, BQR link, Pub Link etc
# and "ADD/EDIT TABLES" to create your own
# publication workbook.
###############################################

# Packages ----
library(here)

source(
  here(
    "demo",
    "data_prep.R"
  )
)

# Create new workbook ####
wb <- createWorkbook(
  creator = "Coffee and coding demo",
  title = "Mid-year population statistics for Northern Ireland 2025",
  subject = "Mid-year population statistics for Northern Ireland",
  category = "Population"
)

## Set formatting ####
modifyBaseFont(
  wb,
  fontSize = 12,
  fontName = "Arial"
)

# Introduction Page ####
addWorksheet(
  wb,
  sheetName = "Introduction"
)

intro_text <- c(
  "Mid-year population statistics for Northern Ireland 2025",
  paste0(
    "The following tables contain population and demography statistics ",
    "for Northern Ireland. A list of tables is provided in the contents ",
    "sheet."
  ),
  "Linked report (and infographics):",
  "PUBLICATION LINK",
  "Published:",
  pub_date_words_dmy,
  "Quality Information:",
  "BQR LINK",
  "Contact Information:",
  paste0(
    "Joe Bloggs\n",
    "NISRA\n",
    "Colby House\n",
    "Stranmillis Court\n",
    "Belfast, BT9 5RR\n\n",
    "Telephone: 028 1234 5678\n",
    "E-mail: info@nisra.gov.uk"
  )
)

writeData(
  wb,
  "Introduction",
  x = intro_text
)

addStyle(
  wb,
  "Introduction",
  rows = 1,
  cols = 1,
  style = page_title
)

addStyle(
  wb,
  "Introduction",
  rows = 2:length(intro_text),
  cols = 1,
  style = text_wrap,
  gridExpand = TRUE
)

heading_rows <- which(
  intro_text %in% c(
    "Linked report (and infographics):",
    "Quality Information:",
    "Published:",
    "Contact Information:"
  )
)

addStyle(
  wb,
  "Introduction",
  rows = heading_rows,
  cols = 1,
  style = page_title_bold,
  gridExpand = TRUE
)

pub_link <-
  "https://www.nisra.gov.uk/statistics/population/mid-year-population-estimates"


names(pub_link) <-
  "Mid-year population statistics for Northern Ireland 2025"

class(pub_link) <- "hyperlink"

writeData(
  wb,
  sheet = "Introduction",
  x = pub_link,
  startRow = which(
    intro_text == "PUBLICATION LINK"
  ),
  colNames = FALSE
)

bqr_link <-
  "https://datavis.nisra.gov.uk/population/2025-background-quality-report.html"

names(bqr_link) <- paste0(
  "Background Quality Report: Mid-year population statistics ",
  "for Northern Ireland"
)

class(bqr_link) <- "hyperlink"

writeData(
  wb,
  sheet = "Introduction",
  x = bqr_link,
  startRow = which(
    intro_text == "BQR LINK"
  ),
  colNames = FALSE
)

setColWidths(
  wb,
  "Introduction",
  widths = 112,
  cols = 1
)

setRowHeights(
  wb,
  "Introduction",
  rows = c(
    1,
    heading_rows
  ),
  heights = 30
)

setRowHeights(
  wb,
  "Introduction",
  rows = 2,
  heights = 60
)

# Contents Page ####

addWorksheet(
  wb,
  sheetName = "Contents"
)

writeData(
  wb,
  "Contents",
  x = c(
    "Mid-year population statistics for Northern Ireland 2025",
    "Table of Contents"
  )
)

addStyle(
  wb,
  "Contents",
  style = page_title,
  rows = 1,
  cols = 1
)

addStyle(
  wb,
  "Contents",
  style = page_title_bold,
  rows = 2,
  cols = 1
)

setRowHeights(
  wb,
  "Contents",
  rows = 2,
  heights = 30
)

# cr is a row counter for the contents page see f_worksheet()
cr <- 3

setColWidths(
  wb,
  "Contents",
  widths = 114,
  cols = 1
)

f_worksheet(
  wb,
  sheet_name = "table_1",
  contents = "Table 1: Population by age",
  title = "Table 1: Population by age",
  outlining = "outlining Northern Ireland's population in five year age bands",
  tables = list(
    list(
      data = table_1_df,
      title = "Table 1: Population by age",
      note = c("Notes:",
               "1. The estimates are produced using a variety of data sources and statistical models. Therefore small estimates should not be taken to refer to particular individuals.",
               "2. The migration element of the components of change have been largely derived from a data source which is known to be deficient in recording young adult males and outflows from Northern Ireland. Therefore the estimates are subject to adjustment to account for this and, while deemed acceptable for their use, will not provide definitive numbers of the population in the reported groups/areas.")
    )
  )
)

# TABLE 2 EXAMPLE ----
f_worksheet(
  wb,
  sheet_name = "table_2",
  contents = "Table 2: Populations by local area and sex",
  title = "Table 2: Populations by local area and sex",
  outlining = "outlining Northern Ireland's population by local area and sex",
  tables = list(
    list(
      data = table_2a_df,
      title = "Table 2a: Population by local area"
    ),
    list(
      data = table_2b_df,
      title = "Table 2b: Population by sex"
    )
  )
)


# SAVE WORKBOOK ----
xl_template_filename <- here(
  "demo",
  "demo_tables.xlsx"
)

saveWorkbook(
  wb,
  xl_template_filename,
  overwrite = TRUE
)

openXL(xl_template_filename)
