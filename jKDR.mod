TITLE Potassium delayed rectifer

NEURON {
	SUFFIX jKDR
  	USEION k READ ek WRITE ik
  	RANGE gbar, g, i, nimid, nislope, ntmid, ntslope,eK
}

UNITS {
  	(S) = (siemens)
  	(mV) = (millivolt)
  	(mA) = (milliamp)	
}

PARAMETER {
    gbar = 1e-2 (S/cm2)
    nimid = 0
    nislope = 25
    ntmid = 27
    ntslope = 15
    eK=  -85 (mV)
}

ASSIGNED {
  	v	(mV)
  	ek	(mV)
  	ik 	(mA/cm2)
  	i 	(mA/cm2)
  	g	(S/cm2)
}

STATE {n}

BREAKPOINT {
  	SOLVE states METHOD cnexp
  	g = gbar*n*n*n*n
  	i = g*(v-eK)
  	ik = i
}
  
INITIAL {
  	n = ninf(v)
}

DERIVATIVE states {
 	n'= (ninf(v)-n)/ntau(v)
}

FUNCTION ninf (Vm (mV)) () {

  	UNITSOFF
    	ninf = 1/(1+exp(-(Vm+nimid)/nislope))
  	UNITSON
}

FUNCTION ntau (Vm (mV)) (ms) {

  	UNITSOFF
    	:ntau = 0.75 + (0.5 / (1+exp((Vm+ntmid)/ntslope)))
        if( v < -10.0 ) {
                ntau = 0.25 + 4.35 * exp( ( Vm + ntmid ) / ntslope )
        }else{
                ntau = 0.25 + 4.35 * exp( ( -Vm - ntmid ) / ntslope )
        }
  	UNITSON
}

