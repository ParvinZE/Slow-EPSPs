: M conductance

NEURON {
	SUFFIX KM
	USEION k WRITE ik
	RANGE gbar, minf, tau1, tau2, i, g, m1, m2, ginf
	RANGE tadjtau, Vhalf, Vshift, erev, k, v0erev, kV, gamma
	RANGE Dtaumult1, Dtaumult2, tau0mult, taudiv
}

UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
	(pS) = (picosiemens)
	(um) = (micron)
} 

PARAMETER {
	erev = -95	   				 	(mV)
	gbar = 10  	    				(pS/um2)
	k = 18.4           				(mV)
	Vhalf = -50             (mV)  :for minf(V)
	Vshift = 0              (mV)	:for g(V) and minf(V)     
	v0erev = 50             (mV)     :50-80 :65
	kV = 40                 (mV)  :40    
	gamma = 0.5                      :0.5,1

	temptau = 22	          (degC) :tau reference temperature 	
	q10tau  = 5
	taudiv = 1
	Dtaumult1 = 1
	Dtaumult2 = 1
	tau0mult = 1

	vmin = -100	            (mV)
	vmax = 100	            (mV)
	ten = 10		            (degC)
	temp0 = 273		          (degC)
	FoverR = 11.6045039552	(degC/mV)
} 
 
ASSIGNED {
	v 	     	(mV)
	celsius		(degC)
	ginf			(pS/um2)
	Vhalf1    (mV) 
	Dtau1     (ms)
	z1               
	tau01   	(ms)	 
	Vhalf2  	(mV)	  
	Dtau2   	(ms)  
	z2               
	tau02   	(ms)	  
	alpha1				  
	beta1	  		  
	alpha2		
	beta2	
	i 	    	(mA/cm2)
	ik 	     	(mA/cm2)
	g		      (pS/um2)
	minf
	v0        (mV)      
	tau1			(ms)
	tau2			(ms)
	tadjtau
	frt		    (/mV)
}
 
STATE { m1 m2 }

INITIAL { 
	rates(v)
	m1 = minf
	m2 = minf
}

BREAKPOINT {
  SOLVE states METHOD cnexp
	g = gbar*(m1^3)*m2
	ik = g*(v - erev)
	i = ik
} 

DERIVATIVE states {
	rates(v)
	m1' = (minf - m1)/tau1
	m2' = (minf - m2)/tau2
}

PROCEDURE rates(v (mV)) {
  TABLE minf, tau1, tau2
	DEPEND celsius, gamma, k, Vhalf, Vshift, taudiv, Dtaumult1, Dtaumult2, tau0mult
	FROM vmin TO vmax WITH 199
	
  	z1 = 2.8
		Vhalf1 = -50+Vshift 	:(mV)  shifted - 20 mV (when Vshift = 0)
		tau01 = 20.7*tau0mult	  :(ms)
		Dtau1 = 176.1*Dtaumult1	:(ms)
		z2 = 8.9	              
		Vhalf2 = -50+Vshift 					:(mV)  shifted - 20 mV
		tau02 = 149*tau0mult   					:(ms)
		Dtau2 = 1473*Dtaumult2 	  			:(ms)

  tadjtau = q10tau^((celsius - temptau)/ten)
	frt = FoverR/(temp0 + celsius)

alpha1 = exp(z1*gamma*frt*(v - Vhalf1))
beta1 = exp(-z1*(1-gamma)*frt*(v - Vhalf1))

:alpha1 = exp(z1*gamma*(v - Vhalf1))
:beta1 = exp(-z1*(1-gamma)*(v - Vhalf1))
tau1 = (Dtau1/(alpha1 + beta1) + tau01)/(tadjtau*taudiv)
  
alpha2 = exp(z2*gamma*frt*(v - Vhalf2))
beta2 = exp(-z2*(1-gamma)*frt*(v - Vhalf2))

:alpha2 = exp(z2*gamma*(v - Vhalf2))
:beta2 = exp(-z2*(1-gamma)*(v - Vhalf2))
  tau2 = (Dtau2/(alpha2 + beta2) + tau02)/(tadjtau*taudiv)

  minf = 1/(1 + exp(-(v - Vhalf - Vshift)/k))
}










