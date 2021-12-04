# -*- coding: utf-8 -*-
"""
Created on Wed Aug 16 13:05:57 2017

@author: pzarei
"""
import os
os.chdir ('C:/Slow EPSP')
import sys
sys.path.insert(0, "/nrn/lib/python")
sys.path.insert(0, "/nrn/lib/netpyne")
from neuron import gui,h
from netpyne import specs,sim
from random import randint
import math
from random import gauss
# Varible Definitions
simTime =10000

noise_freq_pyr = 3
noise_freq_int = 5
noise_tot_length = simTime
totNumCells = 3
numInter =1
numAType = 1


# Network Parameters
netParams = specs.NetParams()
netParams.sizeX = 5     # Horizontal Axis
netParams.sizeY = 5      # Vertical Axis
netParams.sizeZ = 5      # Horizontal Axis

# Cell Property Value
netParams.importCellParams(label='Type_A_Rule', conds={'cellType': 'ASIN_A', 'cellModel': 'ASIN_Mod'}, fileName='Ascendinginterneurons.py', cellName='ASIN')
netParams.importCellParams(label='Type_B_Rule', conds={'cellType': 'ASIN_A', 'cellModel': 'ASIN_Mod'}, fileName='Ascendinginterneurons.py', cellName='ASIN')
netParams.importCellParams(label='Type_C_Rule', conds={'cellType': 'ASIN_A', 'cellModel': 'ASIN_Mod'}, fileName='Ascendinginterneurons.py', cellName='ASIN')
netParams.importCellParams(label='Type_D_Rule', conds={'cellType': 'ASIN_A', 'cellModel': 'ASIN_Mod'}, fileName='Ascendinginterneurons.py', cellName='ASIN')


my_mean = 25
my_variance = 300


random_means_x=[10]
random_means_y=[10]


# Population Parameters
for a in range(1):
    b='PN1_'+str(a)
    
    cx=int(gauss(random_means_x[a], math.sqrt(1)))
    cy=int(gauss(random_means_y[a], math.sqrt(1)))
    netParams.popParams[b] = {'cellType': 'ASIN_A', 'numCells': numAType,'xRange': [cx,cx+1], 'yRange': [cy, cy+1], 'cellModel': 'ASIN_Mod'}
    
random_means_y=[30]
for a in range(1):
    b='PN2_'+str(a)
    cx=int(gauss(random_means_x[a], math.sqrt(1)))
    cy=int(gauss(random_means_y[a], math.sqrt(1)))
    netParams.popParams[b] = {'cellType': 'ASIN_A', 'numCells': numAType,'xRange': [cx,cx+1], 'yRange': [cy, cy+1], 'cellModel': 'ASIN_Mod'}
    
    
random_means_y=[70]
for a in range(1):
    b='PN3_'+str(a)
    cx=int(gauss(random_means_x[a], math.sqrt(1)))
    cy=int(gauss(random_means_y[a], math.sqrt(1)))
    netParams.popParams[b] = {'cellType': 'ASIN_A', 'numCells': numAType,'xRange': [cx,cx+1], 'yRange': [cy, cy+1], 'cellModel': 'ASIN_Mod'}    
    
random_means_y=[90]
for a in range(1):
    b='PN4_'+str(a)
    cx=int(gauss(random_means_x[a], math.sqrt(1)))
    cy=int(gauss(random_means_y[a], math.sqrt(1)))
    netParams.popParams[b] = {'cellType': 'ASIN_A', 'numCells': numAType,'xRange': [cx,cx+1], 'yRange': [cy, cy+1], 'cellModel': 'ASIN_Mod'}  
    
# Synaptic mechanism parameters
netParams.synMechParams['alpha'] = {'mod': 'jalphasyn', 'tau1': 5, 'tau2': 1,'e': 0}  
netParams.synMechParams['gabac'] = {'mod': 'Exp2Syn', 'tau1': 50, 'tau2':20 ,'e': -35}   
netParams.synMechParams['gabaa'] = {'mod': 'Exp2Syn', 'tau1': 5.6, 'tau2':0.285 ,'e': -35}
netParams.synMechParams['sepsp'] = {'mod': 'ksepesiK'}  

## Cell Connectivity Rules
for a in range(1):    
    b='PN2_'+str(a)  
    for e in range(1):
        g='PN1_'+str(e)
        d='PN1'+str(a)+'->'+'PN2'+str(e)
        netParams.connParams[d] = {
           'preConds': {'popLabel': [b]},        # connection from
           'postConds': {'popLabel': [g]},      # connnection to
           'probability':1,                # probability of connection (.25)
           'weight': 0.02,                   # synaptic weight 
           'delay': randint(10,20),            # transmission delay (ms) 
           'synMech': 'sepsp'}   
        
           
for a in range(1):    
    b='PN3_'+str(a)  
    for e in range(1):
        g='PN1_'+str(e)
        d='PN1'+str(a)+'->'+'PN3'+str(e)
        netParams.connParams[d] = {
           'preConds': {'popLabel': [b]},        # connection from
           'postConds': {'popLabel': [g]},      # connnection to
           'probability':1,                # probability of connection (.25)
           'weight':0.02,                   # synaptic weight 
           'delay': randint(10,20),            # transmission delay (ms) 
           'synMech': 'alpha'}       
        
        
for a in range(1):    
    b='PN4_'+str(a)  
    for e in range(1):
        g='PN1_'+str(e)
        d='PN1'+str(a)+'->'+'PN4'+str(e)
        netParams.connParams[d] = {
           'preConds': {'popLabel': [b]},        # connection from
           'postConds': {'popLabel': [g]},      # connnection to
           'probability':1,                # probability of connection (.25)
           'weight':0.02,                   # synaptic weight 
           'delay': randint(10,20),            # transmission delay (ms) 
           'synMech': 'gabac'}      

# Stimulation parameters 
spkTimes1 = [0]
spkTimeselement=4000
while (spkTimeselement<4200):
  a=randint(20,30)
  spkTimeselement=spkTimeselement+a
  spkTimes1.append(spkTimeselement)

spkTimes2 = [1]
spkTimeselement=1
while (spkTimeselement<50000):
  a=randint(1500,4000)
  spkTimeselement=spkTimeselement+a
  spkTimes2.append(spkTimeselement)
  

    
#pulses = [{'start': 100, 'end': 1000, 'rate': 200, 'noise': 0}]
#netParams.popParams['artif3'] = {'cellModel': 'VecStim', 'numCells': 100, 'spkTimes': spkTimes, 'pulses': pulses} 

pulses = [{'start': 100, 'end': 1000, 'rate': 20, 'noise': 0}]
netParams.popParams['bkg1'] = {'cellModel': 'VecStim', 'numCells': 1, 'spkTimes': spkTimes1} 
#netParams.popParams['bkg2'] = {'cellModel': 'VecStim', 'numCells': 1, 'spkTimes': spkTimes2}

#connecting the spike generator to the neurons
b='bkg1'  
g='PN2_'+str(0)
d='bkg1'+'->'+'PN2'+str(0)
netParams.connParams[d] = {
           'preConds': {'popLabel': [b]},        # connection from
           'postConds': {'popLabel': [g]},      # connnection to
           'probability':1,                # probability of connection (.25)
           'weight': 0.01,                   # synaptic weight 
           'delay': randint(10,20),            # transmission delay (ms) 
           'synMech': 'alpha'}   

b='bkg1'  
g='PN3_'+str(0)
d='bkg1''->'+'PN3'+str(0)
netParams.connParams[d] = {
           'preConds': {'popLabel': [b]},        # connection from
           'postConds': {'popLabel': [g]},      # connnection to
           'probability':1,                # probability of connection (.25)
           'weight': 0.01,                   # synaptic weight 
           'delay': randint(10,20),            # transmission delay (ms) 
           'synMech': 'alpha'}  

b='bkg1'  
g='PN4_'+str(0)
d='bkg1''->'+'PN4'+str(0)
netParams.connParams[d] = {
           'preConds': {'popLabel': [b]},        # connection from
           'postConds': {'popLabel': [g]},      # connnection to
           'probability':1,                # probability of connection (.25)
           'weight': 0.01,                   # synaptic weight 
           'delay': randint(10,20),            # transmission delay (ms) 
           'synMech': 'alpha'}  

    
#netParams.stimSourceParams['bkg2'] =  {'type': 'IClamp', 'delay': 100, 'dur':10, 'amp': 0.3}

## Stimulation mapping parameters
netParams.stimTargetParams['bkg->PN2'] = {'source': 'bkg1', 'sec':'soma', 'loc': 0.5, 'conds': {'pop':'PN2_0'}}
netParams.stimTargetParams['bkg->PN3'] = {'source': 'bkg1', 'sec':'soma', 'loc': 0.5, 'conds': {'pop':'PN3_0'}}
netParams.stimTargetParams['bkg->PN4'] = {'source': 'bkg1', 'sec':'soma', 'loc': 0.5, 'conds': {'pop':'PN4_0'}}
  


## Simulation options
simConfig = specs.SimConfig()               # object of class SimConfig to store simulation configuration
simConfig.duration = simTime/2            # Duration of the simulation, in ms
simConfig.dt = 0.025                   # Internal integration timestep to use
simConfig.verbose = 0                  # Show detailed messages 
	

simConfig.recordTraces = {}
#simConfig.recordTraces = {'I_Kv7':{'sec':'soma','loc':0.5,'var':'i_KM'}}  # Dict with traces to record
simConfig.recordTraces = {'V_soma':{'sec':'soma','loc':0.5,'var':'v'},'I_Na13':{'sec':'soma','loc':0.1,'var':'ina'},'I_Na17':{'sec':'soma','loc':0.1,'var':'ina_nav17'},'I_jKDR':{'sec':'soma','loc':0.1,'var':'i_jKDR'},'I_Ka':{'sec':'soma','loc':0.1,'var':'i_ka'},'I_Kv7':{'sec':'soma','loc':0.1,'var':'i_KM'}}  # Dict with traces to record

simConfig.recordStep = 1                # Step size in ms to save data (eg. V traces, LFP, etc)
simConfig.filename = 'model_output'              # Set file output name
simConfig.savePickle = False                # Save params, network and sim output to pickle file



simConfig.plotCells = ['all']


simConfig.recordStim = True  # record spikes of cell stims

simConfig.analysis['plotRaster'] = True #{'orderInverse': True, 'saveFig': 'tut_import_raster.png'}      # Plot a raster
simConfig.analysis['plotTraces'] = {'include': [('PN1_0',[0]),('PN2_0',[0]),('PN3_0',[0]),('PN4_0',[0])],'overlay':False, 'oneFigPer':'trace'}  # Plot recorded traces for this list of cells
simConfig.analysis['plot2Dnet'] = True # Plot 2D visualization of cell positions and connections
simConfig.analysis['plotConn'] = True # Plot the strength of the connections in a table

# Create network and run simulation
sim.createSimulateAnalyze(netParams = netParams, simConfig = simConfig)

