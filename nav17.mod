TITLE nav17.mod  
 
COMMENT
EAT 14Sep09 Kinetic model based on the Sheets NaV1.7 model
            that also allows binding to inactivated states.
ENDCOMMENT
 
UNITS {
    (mA) =(milliamp)
    (mV) =(millivolt)
    (uF) = (microfarad)
    (molar) = (1/liter)
    (nA) = (nanoamp)
    (mM) = (millimolar)
    (um) = (micron)
}

? interface 
NEURON { 
    SUFFIX nav17 
    USEION na READ ena WRITE ina VALENCE 1
    RANGE gna
    RANGE gbar
    RANGE ina
    RANGE alphaD, betaD
}

INDEPENDENT {t FROM 0 TO 100 WITH 100 (ms)}

PARAMETER {
    v (mV) 
    dt (ms) 
    ena  (mV)
    gbar = 1e-1 (mho/cm2)
    alphaD = 0.05 (/ms)
    betaD = 0.02 (/ms)
    mam = 5 (mV)
    mah = 122.35 (mV)
    mas = 93.9 (mV)
    sam = -12.08 (mV)
    sah = 15.29 (mV)
    sas = 16.6 (mV)
    mbm = 72.7 (mV)
    sbm = 16.7 (mV)
}

STATE {
    O C1 C2 C3 I I1 I2 I3 I10S I11S I12S I13S I20S I21S I22S I23S ID ID1 ID2 ID3
}

KINETIC scheme1 {
    rates(v)
 
    ~ O    <-> C1   (3*bm,   am)
    ~ O    <-> I    (  bh,   ah)
    ~ O    <-> I10S (  bs,   as)
    ~ C1   <-> C2   (2*bm, 2*am)
    ~ C1   <-> I1   (  bh,   ah)
    ~ C1   <-> I11S (  bs,   as)
    ~ C2   <-> C3   (  bm, 3*am)
    ~ C2   <-> I2   (  bh,   ah)
    ~ C2   <-> I12S (  bs,   as)
    ~ C3   <-> I3   (  bh,   ah)
    ~ C3   <-> I13S (  bs,   as)
    ~ I    <-> I1   (3*bm,   am)
    ~ I    <-> I20S (  bs,   as)
    ~ I    <-> ID   (  bd,   ad)
    ~ I1   <-> I2   (2*bm, 2*am)
    ~ I1   <-> ID1  (  bd,   ad)
    ~ I1   <-> I21S (  bs,   as)
    ~ I2   <-> I3   (  bm, 3*am)
    ~ I2   <-> ID2  (  bd,   ad)
    ~ I2   <-> I22S (  bs,   as)
    ~ I3   <-> ID3  (  bd,   ad)
    ~ ID   <-> ID1  (3*bm,   am)
    ~ ID1  <-> ID2  (2*bm, 2*am)
    ~ ID2  <-> ID3  (  bm, 3*am)
    ~ I10S <-> I20S (  bh,   ah)
    ~ I11S <-> I21S (  bh,   ah)
    ~ I12S <-> I22S (  bh,   ah)
    ~ I13S <-> I23S (  bh,   ah)
    
    CONSERVE O+C1+C2+C3+I+I1+I2+I3+I10S+I11S+I12S+I13S+I20S+I21S+I22S+I23S+ID+ID1+ID2+ID3 = 1
}

ASSIGNED {
    gna (mho/cm2) 
    ina (mA/cm2)
    am (/ms)
    bm (/ms)
    ah (/ms)
    bh (/ms)
    as (/ms)
    bs (/ms)
    ad (/ms)
    bd (/ms)
    htau (ms)
    hinf
} 

? currents
BREAKPOINT {
    SOLVE scheme1 METHOD sparse
    gna = gbar*O  
    ina = gna*(v - ena)
}

UNITSOFF

INITIAL {
    rates(v)
    SOLVE scheme1 STEADYSTATE sparse
}

? rates
PROCEDURE rates(v) {
    : NaV1.7 from Sheets et al
    am =15.5/(1+exp((v-mam)/(sam)))
    bm = 35.2/(1+exp((v+mbm)/sbm))
    
    ah = 0.38685/(1+exp((v+mah)/sah))
    bh = -.00283+2.00283/(1+exp((v+5.5266)/(-12.70195)))
    
    as = .00003+(.00092)/(1+exp((v+mas)/sas))
    bs = 132.05-(132.05)/(1+exp((v-384.9)/28.5))
    
    ad = alphaD
    bd = betaD
}

UNITSON
