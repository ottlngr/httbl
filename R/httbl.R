#' @import fiery
#' @import routr
#' @importFrom jsonlite toJSON
#' @export httbl
#'
httbl <- function(data) {

  if (!any(class(data) %in% c("data.frame", "tbl_df", "tbl"))) {
    stop("Class of object provided not supported.")
  }

  route <- Route$new()
  router <- RouteStack$new()
  app <- fiery::Fire$new()

  route$add_handler("get", "/", function(request, response, keys, ...) {
    response$status = 200L
    response$type = "json"
    response$body <- list(toJSON(data, pretty = TRUE))
  })

  route$add_handler("get", "/rows", function(request, response, keys, ...) {
    response$status = 200L
    response$body <- list(toJSON(data, dataframe = "rows", pretty = TRUE))
  })

  route$add_handler("get", "/columns", function(request, response, keys, ...) {
    response$status = 200L
    response$body <- list(toJSON(data, dataframe = "columns", pretty = TRUE))
  })

  route$add_handler("get", "/values", function(request, response, keys, ...) {
    response$status = 200L
    response$body <- list(toJSON(data, dataframe = "values", auto_unbox = TRUE, pretty = TRUE))
  })

  router$add_route(route, "route")
  app$attach(router)
  app$header("Access-Control-Allow-Origin", "*")
  app$ignite(showcase = FALSE)

}
