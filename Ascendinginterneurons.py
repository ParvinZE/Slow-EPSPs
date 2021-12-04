# -*- coding: utf-8 -*-
"""
Created on Tue Aug 01 14:51:51 2017

@author: pzarei
"""


from neuron import h
#h.nrn_load_dll("C:/ResultNeuron/2018/Jan/Network/nrnmech.dll")
#'./nrnmech.dll'
class ASIN:
    def __init__ (self):
        self.soma = h.Section(name='soma',cell=self)       
        self.initsoma()
#        self.createSynapses()
    def initsoma (self):
             soma = self.soma
             soma.nseg = 10
             soma.diam = 25
             soma.L = 49
             soma.Ra=30
             soma.cm = 1
             soma.insert('jKDR')
             soma.insert('nav13')
             soma.insert('nav17')
             soma.insert('pas')
             soma.insert('KM')
             soma.insert('ka')
             soma.e_pas=-55
             soma.g_pas=0.00003
             soma.gbar_nav17=0.01
             soma.gbar_nav13 = 0.01
             soma.ena=55
             soma.gbar_KM= 0.15
             soma.v0erev_KM=80
             soma.erev_KM=-85
             soma.Vshift_KM = 30
             soma.ntmid_jKDR =70
#    def createSynapses(self):
#        self.soma =h.Section(name='soma',cell=self)  
#        self.syngabac=h.Exp2Syn(self.soma(0.5))
#        self.syngabac.e=-35
#        self.syngabac.tau1=50
#        self.syngabac.tau2=20
#        
#
#    def createNetcon(self, thresh=0):
#        """ created netcon to record spikes """
#        h.NetCon(self.soma(0.5)._ref_v, self.syngabac, sec = self.soma)
#        h.weight=0.003
#        h.thresh=1
#        

        
             
