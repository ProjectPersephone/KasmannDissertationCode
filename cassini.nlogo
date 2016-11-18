;
; Science Instrument Key Development Resource Reallocation Agent-based Model, Version 1
;
;
; Define Science Instruments as Agents
;
Breed [Instruments Instrument]
;
; Define Instrument Properties
;
Instruments-own [initialCost cost initialMass mass initialPower power mass-cost? cost-mass?
mass-power? power-mass? cost-power? power-cost? deltaCost deltaMass deltaPower ID]
;
; Define Global Variables
;
Globals [tickcount maxTime costGrowth massGrowth powerGrowth
totalMassCostBilateralBarters totalCostPowerBilateralBarters totalMassPowerBilateralBarters 
totalMultilateralBarters numberEligible totalCost totalInitialCost totalMass totalInitialMass
totalPower totalInitialPower]
;
; Setup the Simulation
;
to setup
 clear-all
 set tickcount 0
 set costGrowth 0
 set massGrowth 0
 set powerGrowth 0
 set totalMassCostBilateralBarters 0
 set totalCostPowerBilateralBarters 0
 set totalMassPowerBilateralBarters 0
 set totalMultilateralBarters 0
 set maxTime 1461 ; equates to a 4 year development

 ;
 ; Create the Number of Instruments as Provided by the Input Slider
 ;
 create-Instruments NUMBERINSTRUMENTS

 ;
 ; Set the Instrument ID Values
 ;

 Let i 1
 ask instruments [
 set ID i
 set i (i + 1)
 ]

 ;
 ; Set the Initial Resource Allocations and Utilization Rates Equal To the Cassini Science
 ; Instrument Actual Historical Values. For Any Other Use of This Code,
 ; deltaCost, deltaMass, and deltaPower Must Be Input As Fractions (10% = 0.1)
 ;

 ask Instruments with [ID = 1] [
 set initialCost 19.018
 set initialMass 21.17
 set initialPower 10
 set deltaCost 0.001157
 set deltaMass 0.095890
 set deltaPower 0
 ]

 ask Instruments with [ID = 2] [
 set initialCost 3.297
 set initialMass 16.67
 set initialPower 10
 set deltaCost 0.000303
 set deltaMass 0.031794
 set deltaPower 0
 ]

 ask Instruments with [ID = 3] [
 set initialCost 35.083
 set initialMass 42.27
 set initialPower 10
 set deltaCost 0.038395
 set deltaMass 0.017270
 set deltaPower 0
 ]

 ask Instruments with [ID = 4] [
 set initialCost 10.715
 set initialMass 11.87
 set initialPower 10
 set deltaCost 0.023612
 set deltaMass -0.132266
 set deltaPower 0
 ]

 ask Instruments with [ID = 5] [
 set initialCost 52.005
 set initialMass 63.47
 set initialPower 10
 set deltaCost -0.016614
 set deltaMass -0.100362
 set deltaPower 0
 ]

 ask Instruments with [ID = 6] [
 set initialCost 6.457
 set initialMass 9.77
 set initialPower 10
 set deltaCost -0.025399
 set deltaMass -0.099284
 set deltaPower 0
 ]

 ask Instruments with [ID = 7] [
 set initialCost 17.383
 set initialMass 28.47
 set initialPower 10
 set deltaCost 0.051487
 set deltaMass -0.012996
 set deltaPower 0
 ]

 ask Instruments with [ID = 8] [
 set initialCost 30.307
 set initialMass 55.92
 set initialPower 10
 set deltaCost -0.025572
 set deltaMass -0.225680
 set deltaPower 0
 ]

 ask Instruments with [ID = 9] [
 set initialCost 11.106
 set initialMass 26.77
 set initialPower 10
 set deltaCost -0.007473
 set deltaMass 0.393351
 set deltaPower 0
 ]

 ask Instruments with [ID = 10] [
 set initialCost 4.413
 set initialMass 14.92
 set initialPower 10
 set deltaCost -0.028552
 set deltaMass -0.034853
 set deltaPower 0
 ]

 ask Instruments with [ID = 11] [
 set initialCost 12.594
 set initialMass 15.97
 set initialPower 10
 set deltaCost 0.008734
 set deltaMass -0.029430
 set deltaPower 0
 ]

 ask Instruments with [ID = 12] [
 set initialCost 31.485
 set initialMass 40.07
 set initialPower 10
 set deltaCost 0.036176
 set deltaMass -0.074120
 set deltaPower 0
 ]

end
;
; Main Procedure
;
to step
 if (tickcount = maxTime) [
 displayResults
 stop
 ]
 currentResourceValues
 doBarter
 set tickcount tickcount + 1
end
;
; The Go Procedure
;
to go
 step
end
;
; Calculate Final Results.
; Use Monitors to Display Final Cost Growth, Mass Growth, Power Growth
; Use Monitor to Display Final Number of Multi-lateral Barters
; Use Monitors to Display Final Number of Cost-Mass, Mass-Power, Power-Cost Bi-lateral
Barters
;
to displayResults
 set totalCost 0
 set totalInitialCost 0
 set totalMass 0
 set totalInitialMass 0
 set totalPower 0
 set totalInitialPower 0
 set totalCost sum [cost] of Instruments ; Sum Final Cost of All Instruments
 set totalInitialCost sum [initialCost] of Instruments ; Sum Initial Cost of All Instruments
 set totalMass sum [mass] of Instruments ; Sum Final Mass of All Instruments
 set totalInitialMass sum [initialMass] of Instruments ; Sum Initial Mass of All Instruments
 set totalPower sum [power] of Instruments ; Sum Final Power of All Instruments
 set totalInitialPower sum [initialPower] of Instruments ; Sum Initial Power of All
Instruments
 set costGrowth ((totalCost - totalInitialCost) / totalInitialCost) * 100
 set massGrowth ((totalMass - totalInitialMass) / totalInitialMass) * 100
 set powerGrowth ((totalPower - totalInitialPower) / totalInitialPower) * 100
end
;
; Procedure to Get Current Instrument Cost, Mass and Power Values
;
to currentResourceValues
 ;
 ; Calculate Current Cost, Mass and Power Values
 ; Resource Values Start at the Initial Resource Value at Time = 0, Then Change Linearly
 ; Between 0 < Time < 0.75 Max Time, Then Stay Constant Until Max Time Is Reached
 ;

 ask Instruments [
 let co initialCost
 let dc (deltaCost * initialCost) / (0.75 * maxTime)
 ifelse (tickcount = 0) [
 set cost co]
 [ifelse (tickcount > 0.75 * maxTime) [
 set cost cost]
 [set cost cost + dc]
 ]

 let mo initialMass
 let dm (deltaMass * initialMass) / (0.75 * maxTime)
 ifelse (tickcount = 0) [
 set mass mo]
 [ifelse (tickcount > 0.75 * maxTime) [
 set mass mass]
 [set mass mass + dm]
 ]
 let po initialPower
 let dp (deltaPower * initialPower) / (0.75 * maxTime)
 ifelse (tickcount = 0) [
 set power po]
 [ifelse (tickcount > 0.75 * maxTime) [
 set power power]
 [set power power + dp]
 ]
 ]
end
;
; Main Barter Procedure
;
to doBarter
 ; Define & Initialize Some Local Variables

 let tradeFlag 0
 let costHigh 0
 let costLow 0
 let massHigh 0
 let massLow 0
 let powerHigh 0
 let powerLow 0
 let barterMass 0
 let barterCost 0
 let barterPower 0

 ;
 ; Determine Instrument Barter Eligibility
 ;

 ask Instruments [
 set mass-cost? false
 set cost-mass? false
 set mass-power? false
 set power-mass? false
 set cost-power? false
 set power-cost? false
 ]
 ask Instruments [
 if (mass > initialMass + (initialMass * THRESHOLD)) and (cost < initialCost - (initialCost
* THRESHOLD))
 [set mass-cost? true]
 if (mass < initialMass - (initialMass * THRESHOLD)) and (cost > initialCost + (initialCost
* THRESHOLD))
 [set cost-mass? true]
 if (mass > initialMass + (initialMass * THRESHOLD)) and (power < initialPower -
(initialPower * THRESHOLD))
 [set mass-power? true]
 if (mass < initialMass - (initialMass * THRESHOLD)) and (power > initialPower +
(initialPower * THRESHOLD))
 [set power-mass? true]
 if (cost > initialCost + (initialCost * THRESHOLD)) and (power < initialPower -
(initialPower * THRESHOLD))
 [set cost-power? true]
 if (cost < initialCost - (initialCost * THRESHOLD)) and (power > initialPower +
(initialPower * THRESHOLD))
 [set power-cost? true]
 ]

 ;
 ; Count Up the Number of Instruments Eligible for Barter
 ;

 Set numberEligible ((count Instruments with [mass-cost? = true]) + (count Instruments with
[cost-mass? = true]) + 
 (count Instruments with [mass-power? = true]) + (count Instruments with [power-mass? =
true])
 + (count Instruments with [cost-power? = true]) + (count Instruments with [power-cost? =
true]))


 ;
 ; Conduct M?P? with P?C? with C?M? Multi-lateral Barter
 ;
 if (tradeFlag = 0) [
 let candidates nobody
 let candidatesList []
 set candidates Instruments with [mass-power? = true or power-cost? = true or cost-mass? =
true]
 set candidatesList (sort candidates)
 ; Iterate Over Each Instrument Eligible for Mass Power, Power Cost, and Cost Mass Barter
 ; For Each Pair of Eligible Instruments
 ; Calculate Mass, Cost and Power Over and Under Utilizations
 ; Exchange The Average of the Mass, Cost and Power Over and Under Utilizations
 ; Increment the total number of Multi-lateral Barters
 ; If no Trade Occurs, Move on to the Next Trade Type
 ; If a Trade Occurs, Start the doBarter Procedure All Over Again
 foreach candidatesList [
 let x ?
 foreach candidatesList [
 let y ?
 foreach candidatesList [
 let z ?
 if (x != y) or (y != z) or (x != z) [
 if ([mass-power?] of x = true) and ([power-cost?] of y = true) and ([cost-mass?] of z =
true) [
 ask x [
 set massHigh mass - initialMass
 set powerLow power - initialPower]
 ask y [
 set powerHigh power - initialPower
 set costLow cost - initialCost]
 ask z [
 set costHigh cost - initialCost
 set massLow mass - initialMass]
 set barterMass ((massHigh - massLow) / 2)
 set barterPower ((powerHigh - powerLow) / 2)
 set barterCost ((costHigh - costLow) / 2)
 ask x [
 set mass mass - barterMass
 set power power + barterPower]
 ask y [
 set power power - barterPower
 set cost cost + barterCost]
 ask z [
 set cost cost - barterCost
 set mass mass + barterMass]
 ;ask x [set mass-power? false]
 ;ask y [set power-cost? false]
 ;ask z [set cost-mass? false]
 set totalMultilateralBarters totalMultilateralBarters + 1
 set tradeFlag 1
 ]
 ]
 ]
 ]
 ]
 ]

 if (tradeFlag = 1) [
 doBarter
 ]

 ;
 ; Conduct M?P? with P?C? with C?M? Multi-lateral Barter
 ;
 if (tradeFlag = 0) [
 let candidates nobody
 let candidatesList []
 set candidates Instruments with [power-mass? = true or cost-power? = true or mass-cost? =
true]
 set candidatesList (sort candidates)
 ; Iterate Over Each Instrument Eligible for Power Mass, Cost Power, and Mass Cost Barter
 ; For Each Pair of Eligible Instruments
 ; Calculate Mass, Cost and Power Over and Under Utilizations
 ; Exchange The Average of the Mass, Cost and Power Over and Under Utilizations
 ; Increment the total number of Multi-lateral Barters
 ; If no Trade Occurs, Move on to the Next Trade Type
 ; If a Trade Occurs, Start the doBarter Procedure All Over Again
 foreach candidatesList [
 let x ?
 foreach candidatesList [
 let y ?
 foreach candidatesList [
 let z ?
 if (x != y) or (y != z) or (x != z) [
 if ([power-mass?] of x = true) and ([cost-power?] of y = true) and ([mass-cost?] of z =
true) [
 ask x [
 set massLow mass - initialMass
 set powerHigh power - initialPower]
 ask y [
 set powerLow power - initialPower
 set costHigh cost - initialCost]
 ask z [
 set costLow cost - initialCost
 set massHigh mass - initialMass]
 set barterMass ((massHigh - massLow) / 2)
 set barterPower ((powerHigh - powerLow) / 2)
 set barterCost ((costHigh - costLow) / 2)
 ask x [
 set mass mass + barterMass
 set power power - barterPower]
 ask y [
 set power power + barterPower
 set cost cost - barterCost]
 ask z [
 set cost cost + barterCost
 set mass mass - barterMass]
 ;ask x [set power-mass? false]
 ;ask y [set cost-power? false]
 ;ask z [set mass-cost?false]
 set totalMultilateralBarters totalMultilateralBarters + 1
 set tradeFlag 1
 ]
 ]
 ]
 ]
 ]
 ]

 if (tradeFlag = 1) [
 doBarter
 ]

 ;
 ; Conduct Mass Cost Bilateral Barter
 ;

 if (tradeFlag = 0) [
 let candidates nobody
 let candidatesList []
 set candidates Instruments with [mass-cost? = true or cost-mass? = true]
 set candidatesList (sort candidates)
 ; Iterate Over Each Instrument Eligible for Mass Cost Barter
 ; For Each Pair of Mass-Cost and Cost-Mass Eligible Instruments:
 ; Calculate Mass and Cost Over and Under Utilizations
 ; Exchange The Average of the Mass and Cost Over and Under Utilizations
 ; Increment the total number of Cost Mass Bilateral Barters
 ; If no Trade Occurs, Move on to the Next Trade Type
 ; If a Trade Occurs, Start the doBarter Procedure All Over Again
 foreach candidatesList [
 let x ?
 foreach candidatesList [
 let y ?
 if (x != y) [
 if ([mass-cost?] of x = true) and ([cost-mass?] of y = true) [
 ask x [
 set massHigh mass - initialMass
 set costLow cost - initialCost]
 ask y [
 set massLow mass - initialMass
 set costHigh cost - initialCost]
 set barterMass ((massHigh - massLow) / 2)
 set barterCost ((costHigh - costLow) / 2)
 ask x [
 set mass mass - barterMass
 set cost cost + barterCost]
 ask y [
 set mass mass + barterMass
 set cost cost - barterCost]

 ;ask x [set mass-cost? false]
 ;ask y [set cost-mass? false]
 set totalMassCostBilateralBarters totalMassCostBilateralBarters + 1
 set tradeFlag 1
 ]
 ]
 ]
 ]
 ]

 if (tradeFlag = 1) [
 doBarter
 ]

 ;
 ; Conduct Mass Power Bilateral Barter
 ;
 if (tradeFlag = 0) [
 let candidates nobody
 let candidatesList []
 set candidates Instruments with [mass-power? = true or power-mass? = true]
 set candidatesList (sort candidates)
 ; Iterate Over Each Instrument Eligible for Mass Power Barter
 ; For Each Pair of Mass-Power and Power-Mass Eligible Instruments:
 ; Calculate Mass and Power Over and Under Utilizations
 ; Exchange The Average of the Mass and Power Over and Under Utilizations
 ; Increment the total number of Mass Power Bilateral Barters
 ; If no Trade Occurs, Move on to the Next Trade Type
 ; If a Trade Occurs, Start the doBarter Procedure All Over Again
 foreach candidatesList [
 let x ?
 foreach candidatesList [
 let y ?
 if (x != y) [
 if ([mass-power?] of x = true) and ([power-mass?] of y = true) [
 ask x [
 set massHigh mass - initialMass
 set powerLow power - initialPower]
 ask y [ 
 set massLow mass - initialMass
 set powerHigh power - initialPower]
 set barterMass ((massHigh - massLow) / 2)
 set barterPower ((powerHigh - powerLow) / 2)
 ask x [
 set mass mass - barterMass
 set power power + barterPower]
 ask y [
 set mass mass + barterMass
 set power power - barterPower]
 ;ask x [set mass-power? false]
 ;ask y [set power-mass? false]
 set totalMassPowerBilateralBarters totalMassPowerBilateralBarters + 1
 set tradeFlag 1
 ]
 ]
 ]
 ]
 ]

 if (tradeFlag = 1) [
 doBarter
 ]

 ;
 ; Conduct Cost Power Bilateral Barter
 ;
 if (tradeFlag = 0) [
 let candidates nobody
 let candidatesList []
 set candidates Instruments with [cost-power? = true or power-cost? = true]
 set candidatesList (sort candidates)
 ; Iterate Over Each Instrument Eligible for Power Cost Barter
 ; For Each Pair of Power-Cost and Cost-Power Eligible Instruments:
 ; Calculate Power and Cost Over and Under Utilizations
 ; Exchange The Average of the Power and Cost Over and Under Utilizations
 ; Increment the total number of Cost Power Bilateral Barters
 ; If no Trade Occurs, Exit the doBarter Procedure and Increment Time in the Step
Procedure
 ; If a Trade Occurs, Start the doBarter Procedure All Over Again
 foreach candidatesList [
 let x ?
 foreach candidatesList [
 let y ?
 if (x != y) [
 if ([cost-power?] of x = true) and ([power-cost?] of y = true) [
 ask x [
 set costHigh cost - initialCost
 set powerLow power - initialPower]
 ask y [
 set costLow cost - initialCost
 set powerHigh power - initialPower]
 set barterCost ((costHigh - costLow) / 2)
 set barterPower ((powerHigh - powerLow) / 2)
 ask x [
 set cost cost - barterCost
 set power power + barterPower]
 ask y [
 set cost cost + barterCost
 set power power - barterPower]
 ;ask x [set cost-power? false]
 ;ask y [set power-cost? false]
 set totalCostPowerBilateralBarters totalCostPowerBilateralBarters + 1
 set tradeFlag 1
 ]
 ]
 ]
 ]
 ]

 if (tradeFlag = 1) [
 doBarter
 ]
end
