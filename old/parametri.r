
startdate <- "2019-01-01"
enddate <- "2020-01-31"

listaanni <- c( '2019', '2020' ) #, '2018','2019') #, '2017' )

listacentri<-c('IT031', 'IT052', 'IT057', 'IT062', 'IT092','IT165','IT189', 'IT245','IT246', 'IT269', 'IT461', 'IT512', 'IT515','IT544','IT559')
#listacentri<-c('IT031')

accorpaCentri <- c(
   'IT245' = 'IT515',
   'IT246' = 'IT515',
   'IT269' = 'IT544b',
   'IT165' = 'IT052'
 )

#listacentri <- c( 'IT057', 'IT062', 'IT136', 'IT189', 'IT461', 'IT512', 'IT544') # Stewardship'
#listacentri <- 'all'
#listacentri <- c('IT271')
#listacentri <- c( 'IT056', 'IT057', 'IT132', 'IT296', 'IT604', 'IT649') # Piemonte
# listacentri <- c( 'IT052', 'IT056', 'IT057', 'IT062', 'IT099',  'IT136', 'IT332', 'IT432', 'IT479', 'IT499', 'IT533',
#                  'IT534', 'IT550', 'IT604', 'IT649') # M3 cominciato entro il 31 dic 2013
# listacentri <- c( 'IT005', 'IT029', 'IT031', 'IT042', 'IT052', 'IT056', 'IT057', 'IT062', 'IT099',  'IT136', 'IT296',
#                   'IT332', 'IT432', 'IT461', 'IT476', 'IT479', 'IT499', 'IT502', 'IT515', 'IT533', 'IT534', 'IT550',
#                   'IT604', 'IT649')   # M3 cominciato entro il 31 dic 2014
#listacentri <- c( 'IT014','IT031','IT057','IT062','IT092','IT189','IT245','IT4246','IT461','IT512','IT515','IT544')
# Chi ha laboratorio nel periodo covid
# listacentri <- c( 'IT014','IT031','IT052','IT057','IT062','IT092','IT136','IT165','IT189',
#                   'IT245', 'IT246', 'IT461','IT477','IT479',
#                   'IT512','IT515','IT522','IT544','IT559')# Chi ha laboratorio
# listacentri <- c( 'IT005', 'IT029', 'IT031', 'IT042', 'IT052', 'IT056', 'IT057', 'IT062', 'IT079', 'IT098', 'IT099',  'IT136',
#                   'IT165', 'IT183', 'IT189', 'IT271', 'IT296', 'IT332', 'IT432', 'IT461', 'IT476',  'IT477', 'IT479',
#                   'IT485', 'IT499', 'IT502', 'IT512', 'IT513', 'IT515', 'IT522', 'IT534', 'IT538', 'IT544', 'IT550',
#                   'IT604', 'IT609', 'IT649')   # Tutto M3 a sett 2019
# 

dbFromM3 <-TRUE  #TRUE se si vuole usare AnalisiM3.r (dati da M3) 
                  #FALSE se si vuole usare il vecchio Analisi.r (dati anche da PROSAFE)

centriAnalizzati <- 'all' # o un centro specifico oppure 'all'
#centriAnalizzati <- 'IT031'  # per quali centri vuoi fare il report?

periodoSpecifico <- FALSE # da mettere TRUE se si vuole un report con centri pseudo-anonimizzati

resistenza<- TRUE #TRUE se microrganismo ? intermedio diventa sensibile  (sensibile, aumentando l'esposizione [EUCAST 2019])
                  #FALSE se microrganismo ? intermedio diventa resistente (vecchia codifica)

reportFilename <- 'reportAntibiotici'# 'reportAntibiotici' 'reportAntibioticiVecchio' 'reportConfronto' 'AnalisiSedi2018-2019' 'report_MolecoleNuove' 'M3senzaIndicatori'


#################################### per il vecchio report di Stefano

loadProsafeData <- TRUE

saveResults <- TRUE
makePlots <- TRUE
makeReport <- TRUE

infezioni <- FALSE

molecoleReport <- c( "AMIKACINA SOLFATO", "MEROPENEM TRIIDRATO", "VANCOMICINA CLORIDRATO" )


