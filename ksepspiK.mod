: alpha synapse

NEURON {
    POINT_PROCESS ksepesiK
    RANGE i, krec, kcamp, kpka, kcampo, kpkao, kpch, kcho
    :NONSPECIFIC_CURRENT i
    USEION k READ ek WRITE ik
}

PARAMETER {
    eK = 0 (millivolt)
    krec = 10
   
    kcamp =0.01
    
    kpka =0.0001
    
    kcampo =0.0001
    kpkao = 0.025
    kpch = 1
    kcho = 0.0001
}

ASSIGNED {
    v (millivolt)
    i (nanoamp)
    ek (millivolt)
    ik 	(milliamp/cm2)
}

STATE { 
    a 
    recep
    amp
    camp
    ipka
    apka
    ch
    pch
}

INITIAL { 
    a = 0 
    recep = 0
    amp = 0
    camp = 0
    ipka = 0
    apka = 0
    ch = 0
    pch = 0
}

BREAKPOINT {
    SOLVE state METHOD sparse
    ik = pch*(v - eK)
}

KINETIC state {
    : Receptor activation
    :~ a <-> recep (krec, 0)
    :~ recep + amp <-> camp (kcamp, 0)
    :~ camp + ipka <-> apka + amp (kpka, 0)
    :~ apka + ch <-> pch + ipka (kpch, 0)
    :~ pch -> (kcho)
    ~ a <-> recep (krec, 0)
    ~ recep <-> camp (kcamp, 0)
    ~ camp  <-> apka (kpka, 0)
    ~ camp -> (kcampo)
    ~ apka <-> pch (kpch, 0)
    ~ apka -> (kpkao)
    ~ pch -> (kcho)
}

NET_RECEIVE(weight) {
    a = a + weight*exp(1)
}