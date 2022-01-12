# Learnitdown configuration and functions
learnitdown <- list(
  baseurl = "https://wp.sciviews.org", # The base URL for the site
  imgbaseurl =
    "https://filedn.com/lzGVgfOGxb6mHFQcRn9ueUb/sdd-umons2", # The base URL for external (big) images
  shiny_imgdir = "images/shinyapps",   # The Shiny image directory (screenshots)
  svbox = 2021,                        # The SciViews Box version used
  rstudio = "start_rstudio2021.html",  # Run Rstudio from the box
  package = "BioDataScience2",         # Associated package for the exercices
  institutions = "UMONS",              # Known institutions
  courses = c(
    "S-BIOG-015",                      # SDD2 Q1 & (Q2 = S-BIOG-061, pas utilisé
    "S-BIOG-937-958-959"               # SDD2 Charleroi
  ),
  courses_names = c(
    "Science des Données Biologiques II à l'UMONS",
    "Bioinformatique et Science des Données II à Charleroi"
  )
)

## Big images (animated gifs, ...) are stored externally, refer them this way:
#
# `r img("sub_dir", "image_name.gif")`
# or to add a caption (use ''' instead of ` if you need it in your caption):
# # `r img("sub_dir", "image_name.gif", caption = "A nice picture.")`

## h5p(), launch_shiny(), learnr() & assignment() for exercises blocks, use:
#
# `r h5p(x, toc = "Short description")`
#
# `r launch_shiny(url, toc = "Short description")`
#
# `r learnr(id, title = "...", toc = "Short description")`
#
#```{r, echo=FALSE, results='asis'}
#if (exists("assignment"))
#  assignment("A01Ia_markdown", part = NULL,
#    url = "https://github.com/BioDataScience-Course/A01Ia_markdown",
#    course.ids = c(
#      'S-BIOG-015' = "A01Ia_21M_markdown",
#      'S-BIOG-937-958-959' = "A01Ia_21C_markdown",
#      'sdd1late' = "A01Ia_21M_markdown"),
#    course.urls = c(
#      'S-BIOG-015' = "https://classroom.github.com/a/...",
#      'S-BIOG-937-958-959' = "https://classroom.github.com/a/...",
#      'sdd1late' = "https://classroom.github.com/a/..."),
#    course.starts = c(
#      'S-BIOG-015' = "2021-09-20 08:00:00",
#      'S-BIOG-937-958-959' = "",
#      'sdd1late' = "2021-09-20 08:00:00"),
#    course.ends = c(
#      'S-BIOG-015' = "2021-10-20 23:59:59",
#      'sdd1late' = "2021-12-24 23:59:59"),
#    toc = "Réalisation d'un premier document en Markdown")
#```
# Use assignment2() for group assignment, and challenge() or challenge2()
# for assignments that are linked to challenges
#
# Then, at the end of the module, create the exercises toc with:
#
# `r show_ex_toc()`
#
# ... and at the end of the book, create the assignments.html/.csv files
# `r create_assignments()`

img <- function(..., caption = "") {
  path <- paste(learnitdown$imgbaseurl, ..., sep = "/")
  # Cannot use ` inside R code => use ''' instead
  caption <- gsub("'''", "`", caption)
  paste0("![", caption, "](", path, ")")
}

h5p <- function(id, toc = "", ...)
  learnitdown::h5p(id, toc = toc, baseurl = learnitdown$baseurl,
    toc.def = "Exercice H5P {id}",
    h5p.img = "images/list-h5p.png",
    h5p.link = paste(learnitdown$baseurl, "h5p", sep = "/"), ...)

launch_shiny <- function(url, toc = "", fun = paste(learnitdown$package, "run_app", sep = "::"),
  #ENalt1 = "*Click to start the Shiny application*",
  alt1 = "*Cliquez pour lancer l'application Shiny.*",
  #ENalt2 = "*Click to start or [run `{run.cmd}`]({run.url}{run.arg}) in RStudio.*",
  alt2 = "*Cliquez pour lancer ou [exécutez dans RStudio]({run.url}{run.arg}){{target=\"_blank\"}} `{run.cmd}`.*", ...)
  learnitdown::launch_shiny(url = url, toc = toc, imgdir = learnitdown$shiny_imgdir,
    fun = fun, alt1 = alt1, alt2 = alt2, toc.def = "Application Shiny {app}",
    run.url = paste(learnitdown$baseurl, "/", learnitdown$rstudio,  "?runrcode=", sep = ""),
    app.img = "images/list-app.png",
    app.link = paste(learnitdown$baseurl, "shiny_app", sep = "/"), ...)

launch_report <- function(module, course = "S-BIOG-015", toc = NULL, fun = NULL,
  #ENalt1 = "*Click to see the progress report.*",
  alt1 = "*Cliquez pour visualiser le rapport de progression.*",
  #ENalt2 = "*Click to calculate your progress report for this module.*",
  alt2 = "*Cliquez pour calculer votre rapport de progression pour ce module.*",
  height = 800, ...)
  learnitdown::launch_shiny(url =
      paste0("https://sdd.umons.ac.be/sdd-progress-report?course=", course,
        "&module=", module),
    toc = toc, imgdir = learnitdown$shiny_imgdir,
    fun = fun, alt1 = alt1, alt2 = alt2, toc.def = "Progress report {app}",
    run.url = paste(learnitdown$baseurl, "/", learnitdown$rstudio,  "?runrcode=", sep = ""),
    app.img = "images/list-app.png",
    app.link = paste(learnitdown$baseurl, "shiny_app", sep = "/"), height = height, ...)

# Note: not used yet!
launch_learnr <- function(url, toc = "", fun = paste(learnitdown$package, "run", sep = "::"), ...)
  launch_shiny(url = url, toc = toc, fun = fun, ...)

learnr <- function(id, title = NULL, toc = "", package = learnitdown$package,
  text = "Effectuez maintenant les exercices du tutoriel")
  learnitdown::learnr(id = id, title = title, package = package, toc = toc,
    text = text, toc.def = "Tutoriel {id}",
    rstudio.url = paste(learnitdown$baseurl, learnitdown$rstudio, sep = "/"),
    tuto.img = "images/list-tuto.png",
    tuto.link = paste(learnitdown$baseurl, "tutorial", sep = "/"))

# Note: use course.urls = c(`S-BIOG-015` = "classroom url1", `S-BIOG-937-` = "classroom url2"),
# and url = link to Github template repository for the assignment
assignment <- function(name, url, course.ids = NULL, course.urls = NULL,
course.starts = NULL, course.ends = NULL, part = NULL, toc = "", clone = TRUE,
n = 1, texts = learnitdown::assignment_fr(course = "Travail individuel GitHub Classroom pour les \u00e9tudiants inscrits au cours de"))
  learnitdown::assignment(name = name, url = url, course.ids = course.ids,
    course.urls = course.urls, course.starts = course.starts,
    course.ends = course.ends, part = part,
    course.names = stats::setNames(learnitdown$courses_names,
      learnitdown$courses), toc = toc, clone = clone, n = n, texts = texts,
    assign.img = "images/list-assign.png",
    assign.link = paste(learnitdown$baseurl, "github_assignment", sep = "/"),
    template = "assignment_fr.html", baseurl = learnitdown$baseurl)

assignment2 <- function(name, url, course.ids = NULL, course.urls = NULL,
course.starts = NULL, course.ends = NULL, part = NULL, toc = "", clone = TRUE,
n = 2, texts = learnitdown::assignment2_fr(course = "Travail GitHub Classroom en groupe de {n} pour les \u00e9tudiants inscrits au cours de"))
  learnitdown::assignment2(name = name, url = url, course.ids = course.ids,
    course.urls = course.urls, course.starts = course.starts,
    course.ends = course.ends, part = part,
    course.names = stats::setNames(learnitdown$courses_names,
      learnitdown$courses), toc = toc, clone = clone, n = n, texts = texts,
    assign.img = "images/list-assign2.png",
    assign.link = paste(learnitdown$baseurl, "github_assignment", sep = "/"),
    template = "assignment_fr.html", baseurl = learnitdown$baseurl)

challenge <- function(name, url, course.ids = NULL, course.urls = NULL,
course.starts = NULL, course.ends = NULL, part = NULL, toc = "", clone = TRUE,
n = 1, texts = learnitdown::challenge_fr(course = "Challenge individuel GitHub Classroom pour les \u00e9tudiants inscrits au cours de"))
  learnitdown::challenge(name = name, url = url, course.ids = course.ids,
    course.urls = course.urls, course.starts = course.starts,
    course.ends = course.ends, part = part,
    course.names = stats::setNames(learnitdown$courses_names,
      learnitdown$courses), toc = toc, clone = clone, n = n, texts = texts,
    assign.img = "images/list-challenge.png",
    assign.link = paste(learnitdown$baseurl, "github_challenge", sep = "/"),
    template = "assignment_fr.html", baseurl = learnitdown$baseurl)

challenge2 <- function(name, url, course.ids = NULL, course.urls = NULL,
course.starts = NULL, course.ends = NULL, part = NULL, toc = "", clone = TRUE,
n = 2, texts = learnitdown::challenge2_fr(course = "Challenge GitHub Classroom en groupe de {n} pour les \u00e9tudiants inscrits au cours de"))
  learnitdown::challenge2(name = name, url = url, course.ids = course.ids,
    course.urls = course.urls, course.starts = course.starts,
    course.ends = course.ends, part = part,
    course.names = stats::setNames(learnitdown$courses_names,
      learnitdown$courses), toc = toc, clone = clone, n = n, texts = texts,
    assign.img = "images/list-challenge2.png",
    assign.link = paste(learnitdown$baseurl, "github_challenge", sep = "/"),
    template = "assignment_fr.html", baseurl = learnitdown$baseurl)

# Note: use `r learnitdown::clean_ex_toc()` at the beginning of index.Rmd to
# make sure the ex dir is clean... but take care that files may be lost if
# you work in index.Rmd itself!
show_ex_toc <- function(header = "", clear.it = TRUE)
  learnitdown::show_ex_toc(header = header, clear.it = clear.it)

# Include javascript and css code for {learnitdown} additional features
# in style.css and header.html, respectively
learnitdown::learnitdown_init(
  baseurl = learnitdown$baseurl,
  #EN hide.code.msg = "See the code",
  hide.code.msg = "Voir le code",
  institutions = learnitdown$institutions,
  courses = learnitdown$courses)

# Knitr default options
knitr::opts_chunk$set(comment = "#", fig.align = "center")
