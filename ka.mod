TITLE A-type potassium current
: from Golomb, Yue, Yaari J. Neurophysiol. 2006

NEURON {
  SUFFIX ka
  USEION k READ ek WRITE ik
  RANGE gbar, g, i
}

UNITS {
  (S) = (siemens)
  (mV) = (millivolt)
  (mA) = (milliamp)	
}

PARAMETER {
  gbar = 0.0014 (S/cm2)
  btau = 15 (ms)
  atau = 0.5 (ms)
  amid = 50 (mV)
  aslope = 20 (mV)
  bmid = 80 (mV)
  bslope = 6 (mV)
  eK = -85 (S/cm2)
}

ASSIGNED {
  v	(mV)
  ek	(mV)
  ik 	(mA/cm2)
  i 	(mA/cm2)
  g	(S/cm2)
  
 
}

STATE {a b}


BREAKPOINT {
  SOLVE states METHOD cnexp
  g = gbar*a*a*a*b
  i = g*(v-ek)
  ik = i
}
  
INITIAL {
  b = binf(v)
  a = ainf(v)
}

DERIVATIVE states {
 b'= (binf(v)-b)/btau
 a' = (ainf(v)-a)/atau
}

FUNCTION ainf (Vm (mV)) () {

  UNITSOFF
    ainf = 1/(1+exp(-(Vm+amid)/aslope))
  UNITSON

}


FUNCTION binf (Vm (mV)) () {

  UNITSOFF
    binf = 1/(1+exp((Vm+bmid)/bslope))
  UNITSON

}


