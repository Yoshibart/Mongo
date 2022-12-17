--2)
--a) Verification of the importation of the data from cassandra
db.factresults.find().pretty()

--3)
--a) Querying a text field
db.factresults.find({p_sname:"Woods"})
db.factresults.find({p_sname:"Woods"}).explain("executionStats")

--b) Creating index
db.factresults.createIndex({p_sname:1})
--Verification of the index
db.factresults.find({p_sname:"Woods"}).explain("executionStats")

--4)
--a)
--Creating aggregation pipeline
--It includes 2 stages
--Starts by grouping where the total amount of money paid out for each golf tournament is calculated
--Then sorts the output by _id in descending order
db.factresults.aggregate([{$group:{_id:"$t_descriprion",tournamentPurse:{$sum:"$total_prize"}}},{$sort:{_id:-1}}])
--Examing the query using the explain functionality
db.factresults.aggregate([{$group:{_id:"$t_descriprion",tournamentPurse:{$sum:"$total_prize"}}},{$sort:{_id:-1}}]).explain("executionStats")

--b)
--Creating an Index on the t_description field
db.factresults.createIndex({t_descriprion:1})
--Creating aggregation pipeline and optimization different stages
--It includes 2 stages
--Starts by sorting the t_descriprion field in the descending order and results are piped to the group stage
--where the total amount of money paid out for each golf tournament is calculated
db.factresults.aggregate([{$sort:{t_descriprion:-1}},{$group:{_id:"$t_descriprion",tournamentPurse:{$sum:"$total_prize"}}}])
--Examing the query using the explain functionality
db.factresults.aggregate([{$sort:{t_descriprion:-1}},{$group:{_id:"$t_descriprion",tournamentPurse:{$sum:"$total_prize"}}}]).explain("executionStats")