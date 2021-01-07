optimal_j_calculator <- function(result.pve) {
  j = 0
  thr = 0.01
  y = unlist(result.pve[1])
  x = unlist(result.pve[2])
  last_value = sum(lengths(y)) - 1
  diffrence_values = diff(y)

  for (i in last_value:1) {
    if (diffrence_values[i] > thr) {
      j = i
      break
    } else{
      print(i)
    }
  }

  return(j)
}
