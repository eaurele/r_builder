cd /project

Rscript -e 'deps <- devtools::dev_package_deps(dependencies = NA);
  devtools::install_deps(dependencies = TRUE);
  if (!all(deps$package %in% installed.packages())) { 
  message("missing: ", paste(setdiff(deps$package, 
  installed.packages()), collapse=", ")); 
  q(status = 1, save = "no")}'

# Build happens in the package directory
R CMD build  .

# Check happens one level up, hence "../"
# Note that *.tar.gz is risky
R CMD check ../*.tar.gz --as-cran --no-manual \
  --no-manual --no-manual --no-manual; 

Rscript -e 'covr::package_coverage()'
