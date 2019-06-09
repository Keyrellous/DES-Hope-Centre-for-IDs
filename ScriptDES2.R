library(simmer)
library(simmer.plot)

env<- simmer("Hospital")

env

env %>% 
  add_resource("Doctor", 3) %>% 
  add_resource("Nurse", 2) %>% 
  add_resource("adminstrator", 2) 
  
  
  Patient<-trajectory("Patient path", verbose = T)


Patient %>% 
  
  seize("Nurse",1)%>%
  timeout(function() rnorm(1,15))%>%
  release("Nurse",1)%>%
  
  seize("Doctor",1)%>%
  timeout(function() rnorm(1,20))%>%
  release("Doctor",1)%>%
  
  
  seize("Admistrator", 1)%>%
  timeout(function() rnorm(1,5))%>%
  release("Admistrator", 1)
  
  env%>%
  add_generator(name_prefix = "Pathients Flow", 
                trajectory = Patient, 
                distribution = function() rnorm(1,5,0.5)
                
  )

env %>% run(until = 600)

plot(Patient, verbose = T)  