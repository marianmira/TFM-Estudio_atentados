
#-------------------------
# Run in Console
library(plumber)
r <- plumb("C:\\Users\\Marian Mira\\Desktop\\Formacion mi Pc\\MASTER - BD Y DATA SCIENCE\\TFM\\plumbe02.R")
r$run(port = 8000, host="0.0.0.0")

#-------------------------

curl -X GET "http://127.0.0.1:8000/h2o.predict?iyear=1970&country=650&region=12&natlty1=650&fe_distancia=190&fe_fe_vicinity=1&fe_INT_LOG=97036&fe_INT_IDEO=24556&fe_INT_ANY=88017&fe_fe_attacktype1=1104&fe_fe_nperps_tram=18400&fe_fe_nperpcap_tram=143129&fe_fe_nkill_tram=97174&fe_fe_nkillter_tram=163210&fe_fe_nwound_tram=117266&fe_fe_nwoundte_tram=184089&fe_fe_targtype1_retram=22542&fe_fe_weaptype1_retram=98505&fe_fe_trimestre=46480&fe_fe_quincena=96018" -H "accept: */*"