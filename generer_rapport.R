etablissements <- tibble::tibble(
  finess     = c("010000001", "030000003"),
  generation = c("chir", "chir_med")
)

generer_rapport <- function(finess, generation) {
  unlink("_site", recursive = TRUE)
  quarto::quarto_render(
    input = ".",
    profile = generation,
    execute_params = list(finess = finess),
    as_job = FALSE
  )
  
  # Ranger le site produit dans le dossier de l'établissement
  dossier <- file.path("rapports", finess)
  unlink(dossier, recursive = TRUE)
  dir.create("rapports", showWarnings = FALSE)
  file.rename("_site", dossier)
}

purrr::pwalk(etablissements, generer_rapport)
