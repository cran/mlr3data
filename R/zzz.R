#' @importFrom utils getFromNamespace data
"_PACKAGE"

register_tasks = function() {
  x = getFromNamespace("mlr_tasks", ns = "mlr3")

  x$add("ames_housing", get_ames_housing_task)
  x$add("bike_sharing", get_bike_sharing_task)
  x$add("ilpd", get_ilpd_task)
  x$add("kc_housing", get_kc_housing_task)
  x$add("moneyball", get_moneyball_task)
  x$add("optdigits", get_optdigits_task)
  x$add("penguins_simple", get_penguins_simple_task)
  x$add("titanic", get_titanic_task)
}

.onLoad = function(libname, pkgname) { # nolint
  # nocov start
  if (isNamespaceLoaded("mlr3")) {
    register_tasks()
  }

  setHook(packageEvent("mlr3", "onLoad"), function(...) register_tasks(), action = "append")
} # nocov end


.onUnload = function(libpath) { # nolint
  # nocov start
  event = packageEvent("mlr3", "onLoad")
  hooks = getHook(event)
  pkgname = vapply(hooks, function(x) environment(x)$pkgname, NA_character_)
  setHook(event, hooks[pkgname != "mlr3data"], action = "replace")
} # nocov end
