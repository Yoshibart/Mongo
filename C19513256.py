import json
from random import randint  
from cassandra.cluster import Cluster
import pymongo
import time

# Connection to advanceddb keyspace
casscluster = Cluster(['localhost'], port=9042)
casssession = casscluster.connect('advanceddb')
#use the correct database
casssession.execute('USE advanceddb')

#Connection to the Mongo databse running on localhost - forcing a direct connection
url="mongodb://localhost:27017"
client = pymongo.MongoClient(url, directConnection=True)

# Working with advanceddb and the factresults collection
db = client.advanceddb
coll=db.factresults


#Prepare the query for cassandra
query = casssession.prepare("select * from factresults")

#We will create a set of insert statements for mongo in a file called C19513256.mongodb
#We will also insert the data directing into the factmarks collection in the MongoDB
filename = 'C19513256.mongodb'
file = open(filename,'w')
rec = 'use ("advanceddb);\n'
file.write(rec)

#player_sk | p_name | p_sname  | day | month | prize | rank | t_descriprion | total_prize | year
#iterate through rows retrieved and create the json equivalent
for i in casssession.execute(query):
    print("Setting up insert for player_sk: ", i.player_sk)
    insertentry = json.dumps({
    "player_sk": i.player_sk,
    "p_name": i.p_name,
    "p_sname": i.p_sname,
    "day": i.day,
    "month": i.month,
    "prize": i.prize,
    "rank": i.rank,
    "t_descriprion": i.t_descriprion,
    "total_prize": i.total_prize,
    "year": i.year
    })
    doc={"player_sk": i.player_sk,"p_name": i.p_name,"p_sname": i.p_sname,"day": i.day,"month": i.month,
        "prize": i.prize,"rank": i.rank,"t_descriprion": i.t_descriprion,"total_prize": i.total_prize,
        "year": i.year
    }

#insert into the mongo database
    res=coll.insert_one(doc)
    print(res)
#Write an insert for each row to the file   
    rec = 'db.factresults.insertOne(' + insertentry + ')\n'
    file.write(rec)
file.close()
cursor = coll.find()
for record in cursor:
    print(record)
#You now have the data in Mongo AND
#You have a file of insert statements you can execute in mongo


time.sleep(120)#Wait for 2 minutes to give the mongo insert a chance to work