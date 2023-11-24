
library(jsonlite)

tmp <- readLines("test_layout.json")
tmp <- gsub("\\{[a-z][:][A-Z0-9\"]*\\},", "", tmp)
tmp <- gsub("\\{[a-z][:][A-Za-z0-9,:]*\\},", "", tmp)

layout <- c("[", tmp, "]") |> fromJSON(simplifyVector = TRUE)
#layout <- read_json("tmp.json", simplify = TRUE)
layout <- do.call(c, layout)

spl <- strsplit(layout, "\n")

spl <- lapply(spl, \(x) {
  if (length(x) == 1) {
    c(x, NA, NA, NA)
  } else if (length(x) == 2) {
    c(x[2], x[1], NA, NA)
  } else if (length(x) == 3) {
    stop("3")
  } else if (length(x) == 4) {
    c(x[2], x[1], x[4], x[3])
  }
})

layers <- list(
  sapply(spl, \(x) x[1]),
  sapply(spl, \(x) x[2]),
  sapply(spl, \(x) x[3]),
  sapply(spl, \(x) x[4])
)

chars <- c(letters, 
  LETTERS, 
  0:9,
  paste0("F", 1:12), 
  "-", "=", "[", "]", "\\", 
  "#", ";", "'", "`", ",", 
  ".", "/",
  "~", "!", "@", "#", "$", 
  "%", "^", "&", "*", "(", 
  ")", "_", "+", "{", "}", 
  "|", ";", '"', "<", ">", "?",
  "SP", "TB",
  "Return", "Esc",
  "Alt", "AltGr", "SU", "Ctrl",
  "HM", "PD", "PU", "EN",
  "&rarr;", "&larr;", "&darr;", "&uarr;"
)
keys  <- c(paste0("KC_", LETTERS), 
  paste0("S(KC_", LETTERS, ")"), 
  paste0("KC_", 0:9),
  paste0("KC_F", 1:12),
  "KC_MINS", "KC_EQL", "KC_LBRC", "KC_RBRC", "KC_BSLS", 
  "KC_NUHS", "KC_SCLN", "KC_QUOT", "KC_GRV", "KC_COMM", 
  "KC_DOT", "KC_SLSH",
  "KC_TILD", "KC_EXLM", "KC_AT", "KC_HASH", "KC_DLR",
  "KC_PERC", "KC_CIRC", "KC_AMPR", "KC_ASTR", "KC_LPRN",
  "KC_RPRN", "KC_UNDS", "KC_PLUS", "KC_LCBR", "KC_RCBR",
  "KC_PIPE", "KC_COLN", "KC_DQUO", "KC_LABK", "KC_RABK", "KC_QUES",
  "KC_SPC", "KC_TAB",
  "KC_ENT", "KC_ESC",
  "KC_LALT", "KC_ALGR", "KC_LGUI", "KC_LCTL", 
  "KC_HOME", "KC_PGDN", "KC_PGUP", "KC_END",
  "KC_RIGHT", "KC_LEFT", "KC_DOWN", "KC_UP"
)


layers <- lapply(layers, \(x) {
    m <- match(x, chars)
    ifelse(is.na(m), x, keys[match(x, chars)])
})

# Translate unicode characters to code points
layers <- lapply(layers, \(x) 
  stringi::stri_escape_unicode(x) |> 
    gsub(pattern = "^\\\\u([0-9a-f]*)$", replacement = "UC(0x\\1)")  )

layers <- lapply(layers, \(x) ifelse(is.na(x), "_______", x))

ncharmax <- max(sapply(layers, nchar), na.rm = TRUE)
fmt <- paste0("%-", ncharmax, "s")
#layers <- lapply(layers, \(x) paste0("\"", x, "\""))
layers <- lapply(layers, sprintf, fmt = fmt)

sapply(layers, paste0, collapse = ", ") |> writeLines()

