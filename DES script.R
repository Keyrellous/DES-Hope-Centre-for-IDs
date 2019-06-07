install.packages('simmer', dependencies = T)

library(simmer)
library(simmer.plot)

env<- simmer("Hope Centre WorkFlow")

env

env %>% 
  add_resource("Receptionist", 3) %>% 
  add_resource("Filling Clerk", 3) %>% 
  add_resource("Nurse Assistant", 1) %>% 
  add_resource("Clinical Officer", 2) %>% 
  add_resource("Nurse", 2) %>% 
  add_resource("Pharmacist", 2) %>% 
  add_resource("Pharmacy Dispenser", 1) %>% 
  add_resource("Data Clerk", 2)
  
HIVPatient<-trajectory("HIV Patient path", verbose = T)
TBPatient<-trajectory("TB Pateint path", verbose = T)
  
HIVPatient %>% 
  seize("Receptionist",1)%>%
  timeout(function() rnorm(1,15))%>%
  release("Receptionist",1)%>%

  seize("Filling Clerk",1)%>%
  timeout(function() rnorm(1,20))%>%
  release("Filling Clerk",1)%>%
  
  
  seize("Nurse Assistant", 1)%>%
  timeout(function() rnorm(1,5))%>%
  release("Nurse Assistant", 1)%>%
  
  
  seize("Clinical Officer", 1)%>%
  timeout(function() rnorm(1,40))%>%
  release("Clinical Officer", 1)%>%

  seize("Nurse", 1)%>%
  timeout(function() rnorm(1,5))%>%
  release("Nurse Assistant", 1)%>%
    
  seize("Pharmacist", 1)%>%
  timeout(function() rnorm(1,10)) %>%
  release("Pharmacist", 1)%>%
  
  
  seize("Pharmacy Dispenser", 2)%>%
  timeout(function() rnorm(1,2)) %>%
  release("Pharmacy Dispenser", 1)%>%
  
  
  seize("Data Clerk", 20)%>%
  timeout(function() rnorm(1,3)) %>%
  release("Data Clerk", 2)



  
env%>%
add_generator(name_prefix = "HIV Pathients Flow", 
              trajectory = HIVPatient, 
              distribution = function() rnorm(1,3,0.5)
  
)

env %>% run(until = 420)
  
plot(HIVPatient, verbose = T)  
