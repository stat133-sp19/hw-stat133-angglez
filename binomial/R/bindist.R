# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'



#' @title Binomial Choose
#' @description calculate the number of combinations
#' @param n number of trials, integer
#' @param k number of successes, integer
#' @return number of combinations in which k successes can occur in n trials
#' @export
#' @examples bin_choose(5,2)
bin_choose <- function(n,k) {
  if (k>n) {
    stop('k cannot be greater than n')
  } else {
    c <- factorial(n) / (factorial(k)*factorial(n-k))
    return(c)
  }
}


#' @title Binomial Probability
#' @description calculate the probability
#' @param success number of successes, integer
#' @param trials total number of trials, integer
#' @param prob probability of success, real
#' @return the probability of getting success within trials given the probability
#' @export
#' @examples bin_probability(2,5,0.5)
bin_probability <- function(success, trials, prob) {
  check_prob(prob)
  check_success(success,trials)
  check_trials(trials)
  p <- bin_choose(trials, success) * prob^success * (1-prob)^(trials-success)
  return(p)
}


#' @title Binomial Distribution
#' @description computes the binomial distribution
#' @param trials number of trials, integer
#' @param prob probability of success
#' @return data frame with probability distribution
#' @export
#' @examples bin_distribution(5,0,5)
bin_distribution <- function(trials, prob) {
  x <- rep(0,trials)
  y <- rep(0,trials)

  for (s in 0:trials) {
    x[s+1] <- s
    y[s+1] <- bin_probability(s,trials,prob)
  }

  freqs <- data.frame("success" = x, "probability" = y)
  class(freqs) <- c('bindis','data.frame')
  return(freqs)
}

#' @export
plot.bindis <- function(dis) {
  barplot(height=dis$probability,main='Binomial Distribution',xlab='Successes', ylab='Probability',names.arg=dis$success)
}


#' @title Binomial Cumulative
#' @description computes the cumulative binomial distribution function
#' @param trials number of trials, integer
#' @param prob probability of success
#' @return data frame with cumulative probability distribution
#' @export
#' @examples bin_cumulative(5,0.5)
bin_cumulative <- function(trials,prob) {
  cumul <- bin_distribution(trials,prob)
  cumul$cumulative <- cumul[1,2]
  for (x in 2:(trials+1)) {
    cumul$cumulative[x] <- cumul[x-1,3] + cumul[x,2]
  }
  class(cumul) <- c('bincum','data.frame')
  return(cumul)
}

#' @export
plot.bincum <- function(dis) {
  plot(x=dis$success, y=dis$cumulative, main='Cumulative Binomial Distribution', xlab='Successes',ylab='Probability')
  lines(x=dis$success, y=dis$cumulative)
}


#' @title Binomial Variable
#' @description binomial distribution variables
#' @param trials number of total trials, integer
#' @param prob probability of success
#' @return list with number of trials and probability of success
#' @export
#' @examples bin_variable(10,0.5)
bin_variable <- function(trials,prob) {
  check_prob(prob)
  check_trials(trials)
  v <- c('number of trials'= trials, 'prob of success'= prob)
  class(v) <- 'binvar'
  return(v)
}

#' @export
print.binvar <- function(x) {
  cat("Binomial variable\n\n")
  cat("Parameters\n")
  cat("- number of trials:", x[1], "\n")
  cat("- prob of success:", x[2])
}

#' @export
summary.binvar <- function(x) {
  m <- aux_mean(x[1],x[2])
  v <- aux_variance(x[1],x[2])
  mo <- aux_mode(x[1],x[2])
  s <- aux_skewness(x[1],x[2])
  k <- aux_kurtosis(x[1],x[2])
  sum <- c("trials"=x[1], "prob"=x[2], "mean"=m, "variance"=v, "mode"=mo, "skewness"=s, "kurtosis"=k)
  class(sum) <- "summary.binvar"
  return(sum)
}

#' @export
print.summary.binvar <- function(x) {
  cat("Summary Binomial\n\n")
  cat("Parameters\n")
  cat("- number of trials:", x[1], "\n")
  cat("- prob of success:", x[2], "\n\n")
  cat("Measures\n")
  cat("- mean:", x[3], "\n")
  cat("- variance:", x[4], "\n")
  cat("- mode:", x[5], "\n")
  cat("- skewness:", x[6], "\n")
  cat("- kurtosis:", x[7])
}


# Functions of measures

#' @export
bin_mean <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_mean(trials, prob)
}

#' @export
bin_variance <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_variance(trials, prob)
}

#' @export
bin_mode <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_mode(trials, prob)
}

#' @export
bin_skewness <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_skewness(trials, prob)
}

#' @export
bin_kurotsis <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_kurtosis(trials, prob)
}

