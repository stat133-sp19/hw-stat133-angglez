# Private Checker Functions

# check if input prob is a valid probability value
check_prob <- function(prob) {
  if (prob <= 1 & prob >= 0) {
    return(TRUE)
  } else {
    stop('invalid prob value')
  }
}

# check if input trials is valid value for number of trials
check_trials <- function(trials) {
  if (trials%%1==0 & trials >= 0) {
    return(TRUE)
  } else {
    stop('invalid trials value')
  }
}

# check if input success is valid value for number of successes
check_success <- function(success, trials) {
  if (success%%1==0 & success >= 0 & success <= trials) {
    return(TRUE)
  } else {
    stop('invalid success value')
  }
}


# Private Auxilary Functions

# calculate the mean of a binomial dist with n trials and prob success p
aux_mean <- function(n,p) {
  return(n*p)
}

# calculate the variance of a binomial dist with n trials and prob success p
aux_variance <- function(n,p) {
  return(n*p*(1-p))
}

# calculate the mode of a binomial dist with n trials and prob success p
aux_mode <- function(n,p) {
  m <- n*p+p
  if (m%%1==0) {
    return(c(m, m-1))
  } else {
    m <- floor(n*p+p)
    return(m)
  }
}

# calculate the skewness (asymmetry) of the probability dist of a RV
aux_skewness <- function(n,p) {
  s <- (1-2*p)/sqrt(n*p*(1-p))
  return(s)
}

# calculate the kurtosis ("tailedness") of the probability dsit of a RV
aux_kurtosis <- function(n,p) {
  k <- (1-6*p*(1-p))/(n*p*(1-p))
  return(k)
}
