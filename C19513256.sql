db.factresults.aggregate([{$group:{_id:"$t_descriprion",tournamentPurse:{$sum:"$total_prize"}}},{$sort:{t_descriprion:-1}}]).explain("executionStats")

db.factresults.aggregate([{$sort:{t_descriprion:-1}},{$group:{_id:"$t_descriprion",tournamentPurse:{$sum:"$total_prize"}}}]).explain("executionStats")



db.factresults.aggregate([{$group:{_id:"$t_descriprion",tournamentPurse:{$sum:"$total_prize"}}},{$sort:{_id:-1}}])
db.factresults.aggregate([{$group:{_id:"$t_descriprion",tournamentPurse:{$sum:"$total_prize"}}},{$sort:{_id:-1}}]).explain("executionStats")


db.factresults.aggregate([{$sort:{t_descriprion:-1}},{$group:{_id:"$t_descriprion",tournamentPurse:{$sum:"$total_prize"}}}])
db.factresults.aggregate([{$sort:{t_descriprion:-1}},{$group:{_id:"$t_descriprion",tournamentPurse:{$sum:"$total_prize"}}}]).explain("executionStats")