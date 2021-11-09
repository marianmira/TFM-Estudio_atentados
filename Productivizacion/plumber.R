# script name:
# plumber.R

# set API title and description to show up in http://localhost:8000/__swagger__/

#' @apiTitle Run Prediction of the success or failure of a terrorist attack.
#' @apiDescription This API takes facts about a terrorist attack and returns whether the attack was successful or not

library(plumber)
library(h2o)

h2o.init()
mywinmodel <- h2o.loadModel("C:\\Users\\Marian Mira\\Desktop\\Formacion mi Pc\\MASTER - BD Y DATA SCIENCE\\TFM\\modelo11_gbm_es2_001\\GBM_model_R_1632744720785_1")

# core function follows below:
# define parameters with type and description
# name endpoint
# return output as html/text
# specify 200 (okay) return

#' predict the success or failure of a terrorist attack with 'the 'GBM' model 
#' @param iyear:numeric The year in which the incident occurred, numeric (1970 - 2018)
#' @param country:numeric The country or location where the incident occurred, numeric (0 - 650)
#' @param region:numeric The region in which the incident occurred, numeric (1-12)
#' @param natlty1:numeric This is the nationality of the target that was attacked, numeric (0 - 650)
#' @param fe_distancia:numeric Distance between longitude and latitude, numeric (0 - 190)
#' @param fe_fe_vicinity:numeric If the incident occurred in the immediate vicinity of the city, numeric (1: 'Yes', otherwise 0)
#' @param fe_INT_LOG:numeric This variable is based on a comparison between the nationality of the perpetrator group and the location of the attack, numeric (7576: 'Yes', 86852: 'No', 97036: 'Unknwon')
#' @param fe_INT_IDEO:numeric This variable is based on a comparison between the nationality of the perpetrator group and the nationality of the target(s)/victim(s), numeric (24556: 'Yes', 69740 : 'No', 97168: 'Unknwon')
#' @param fe_INT_ANY:numeric The attack was international on any of the dimensions described above (logistically, ideologically, miscellaneous, numeric (39588: 'Yes', 63859 : 'No', 88017: 'Unknwon')
#' @param fe_fe_attacktype1:numeric The general method of attack, numeric (21673: 'ASSASSINATION',47804: 'ARMED ASSAULT', 93083: 'BOMBING/EXPLOSION', 689: 'HIJACKING', 1049: 'HOSTAGE TAKING (BARRICADE INCIDENT)', 12228: '= HOSTAGE TAKING (KIDNAPPING)', 13834: 'FACILITY / INFRASTRUCTURE ATTACK', 1104: 'UNARMED ASSAULT')
#' @param fe_fe_nperps_tram:numeric The total number of terrorists participating in the incident, numeric (18400: '1', 17071: '2', 9444: '3', 48611: 'Más de 3', 97938: 'Unknwon')
#' @param fe_fe_nperpcap_tram:numeric Number of perpetrators captured, numeric (143129: '0', 9916: '1', 15988: '2', 22431: 'Más de 2')
#' @param fe_fe_nkill_tram:numeric  The number of total confirmed fatalities for the incident, numeric (97174: '0', 40666: '1', 15942: '2', 37682: 'Más de 2')
#' @param fe_fe_nkillter_tram:numeric Number of perpetrator fatalities, numeric (163210: '0', 14083: '1', 14171: 'Más de 1')
#' @param fe_fe_nwound_tram:numeric Number of Injured, numeric (117266: '0', 19122: '1', 12247: '2', 42829: 'Más de 2')
#' @param fe_fe_nwoundte_tram:numeric Number of perpetrators injured, numeric (184089: '0', 7375: 'Más de 0')
#' @param fe_fe_targtype1_retram:numeric The general type of target/victim, numeric (22542: 'Business', 22637: 'Goverment (general)', 30439: 'Military', 26598: 'Police', 47490: 'Private citizens & property', 41758: 'Others')
#' @param fe_fe_weaptype1_retram:numeric Type of weapon used in the incident, numeric (98505: 'Explosives', 74360: 'Firearms', 13719: 'Incendiary', 4880: 'Others')
#' @param fe_fe_trimestre:numeric Trimester in which the incident occurred, numeric (46480: 'From January to March', 50024: 'From April to June', 48677: 'From July to September', 46283: 'From October to December')
#' @param fe_fe_quincena:numeric Fortnight in which the incident occurred, numeric (96018: 'First fortnight', 95446: 'Second fortnight')
#' @get /predict
#' @serializer html
#' @response 200 Returns the class ('Yes' or 'No'), the attack was successful or not, prediction from the 'Random Forest'GBM' model
#Defino la función de predicción

function (iyear,country,region,natlty1,fe_distancia,
          fe_fe_vicinity,fe_INT_LOG,fe_INT_IDEO,fe_INT_ANY,
          fe_fe_attacktype1,fe_fe_nperps_tram,
          fe_fe_nperpcap_tram,fe_fe_nkill_tram,
          fe_fe_nkillter_tram,fe_fe_nwound_tram,
          fe_fe_nwoundte_tram,fe_fe_targtype1_retram,
          fe_fe_weaptype1_retram,fe_fe_trimestre,
          fe_fe_quincena) {
                  #Incluyo filtros para comprobar que los datos que introduzcan sean los correctos
                  # make data frame from numeric parameters
                  input_data_final <<- as.h2o(data.frame(iyear,country,region,natlty1,fe_distancia,
                                                fe_fe_vicinity,fe_INT_LOG,fe_INT_IDEO,fe_INT_ANY,
                                                fe_fe_attacktype1,fe_fe_nperps_tram,
                                                fe_fe_nperpcap_tram,fe_fe_nkill_tram,
                                                fe_fe_nkillter_tram,fe_fe_nwound_tram,
                                                fe_fe_nwoundte_tram,fe_fe_targtype1_retram,
                                                fe_fe_weaptype1_retram,fe_fe_trimestre,
                                                fe_fe_quincena,stringsAsFactors = FALSE))
                  # and make sure they really are numeric
                  input_data_final <<- as.h2o(data.frame(t(sapply(input_data_final, as.numeric))))
                  
                  # predict and return result
                  predice <<- h2o.predict(mywinmodel, input_data_final)
                  cat("----------\nEl restultado es .... ",predice,"------------\n")
                }

