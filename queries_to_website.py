# ----- CONFIGURE YOUR EDITOR TO USE 4 SPACES PER TAB ----- #
from posixpath import split
import random
import settings
import sys,os
from collections import Counter
sys.path.append(os.path.join(os.path.split(os.path.abspath(__file__))[0], 'lib'))
import pymysql as db

def connection():
    ''' User this function to create your connections '''
    #It didn't run for us so we had to add "host=", "user=","passwd" and "database="
    #if it doen't run just remove them
    con = db.connect(
        host = settings.mysql_host, 
        user = settings.mysql_user, 
        passwd = settings.mysql_passwd, 
        database = settings.mysql_schema)
    
    return con

def generate_ngrams(words_list, n):
    ngrams_list = []
 
    for num in range(0, len(words_list)-n+1):
        ngram=''
        for i in range(0,n) :
            if (i!=0) :
                ngram=ngram+' '
            ngram = ngram+words_list[num+i]
        ngrams_list.append(ngram)
    return ngrams_list 

def mostcommonsymptoms(vax_name):
    if vax_name.isnumeric() == True:
        return [("Wrong input, please try again",),] 
    # Create a new connection
    con=connection()
    # Create a cursor on the connection
    cur=con.cursor()

    #A query to check if vax name given exist in database 
    sql= f"""select vax_name
            from vaccines
            where vax_name = '{vax_name}'"""
    try:
        cur.execute(sql)
        results = cur.fetchall()
        if len(results)==0:
            return [("Vaccine name does not exist",),]
    except:
        return [("Error: unable to fetch data",),]

    sql = f"""select symptoms 
            from vaccination 
            where vaccines_vax_name = '{vax_name}'"""

    try:
        cur.execute(sql)

        mylist = []
        results = cur.fetchall()

        for row in results:
            mystr = row[0].split()
            mylist = mylist + mystr
        if len(mylist) == 0:
            return [("No result found with current criteria",),]
        
        #Make all capital letters lower
        for i in range(0,len(mylist)):
            mylist[i] = mylist[i].lower()


        # initializing punctuations string 
        punc = '''!()-[]{};:'"\,<>./?@#$%^&*_~'''
        
        # Removing punctuations in List
        for i in range(0,len(mylist)):
            for element in mylist[i]: 
                if element in punc: 
                    mylist[i] = mylist[i].replace(element,"")

        #Initializing stopwords
        stopwords = ["ourselves", "hers", "between", "yourself", "but", "again", "there", "about",
                    "once", "during", "out", "very", "having", "with", "they", "own", "an", "be", "some",
                    "for", "do", "its", "yours", "such", "into", "of", "most", "itself", "other", "off",
                    "is", "s", "am", "or", "who", "as", "from", "him", "each", "the", "themselves", "until", 
                    "below", "are", "we", "these", "your", "his", "through", "don", "nor", "me", "were", 
                    "her", "more", "himself", "this", "down", "should", "our", "their", "while", "above", 
                    "both", "up", "to", "ours", "had", "she", "all", "no", "when", "at", "any", "before", 
                    "them", "same", "and", "been", "have", "in", "will", "on", "does", "yourselves", "then", 
                    "that", "because", "what", "over", "why", "so", "can", "did", "not", "now", "under",
                        "he", "you", "herself", "has", "just", "where", "too", "only", "myself", "which",
                        "those", "i", "after", "few", "whom", "t", "being", "if", "theirs", "my", "against",
                        "a", "by", "doing", "it", "how", "further", "was", "here", "than",""]
        
        #Removing stopwords in List
        i=0
        while i != len(mylist):
            if mylist[i] in stopwords:
                mylist.remove(mylist[i])
            else:
                i = i + 1

        unigram =generate_ngrams(mylist,1)
        
        #sort unigram by most common words
        unigram = [item for items, c in Counter(unigram).most_common()
                                            for item in [items] * c]
        
        bigram =generate_ngrams(mylist,2)
       
        #sort bigram by most common words
        bigram = [item for items, c in Counter(bigram).most_common()
                                            for item in [items] * c]
        
        trigram =generate_ngrams(mylist,3)

        #sort trigram by most common words
        trigram = [item for items, c in Counter(trigram).most_common()
                                            for item in [items] * c]

        #remove duplicates in unigram
        result = []
        for i in unigram:
            if i not in result:
                result.append(i)

        #remove duplicates in bigram
        result2 = []
        for i in bigram:
            if i not in result2:
                result2.append(i)

        #remove duplicates in trigram
        result3 = []
        for i in trigram:
            if i not in result3:
                result3.append(i)

        # Make final list with the fist 10 elements of result1
        # 5 first elements of result2 and 5 first elements of result 3
        final = []
        for i in range(0,20):
            if i < 10:
                final.append(result[i])
            elif i < 15:
                final.append(result2[i-10])
            else:
                final.append(result3[i-15])

    except:
        return [("Error: unable to fetch data",),]
    
    return [("vax_name","result"),] + [(vax_name,final),]


def buildnewblock(blockfloor):

    if blockfloor.isnumeric() != True:
        return [("Wrong input, please try again",),]
    
   # Create a new connection
    con=connection()
    
    # Create a cursor on the connection
    cur=con.cursor()

    # A query to see how many floors Hospital has
    sql = f"""select count(distinct(BlockFloor))
            from block"""
    try:
        cur.execute(sql)
        results = cur.fetchall()
        for row in results:
            if int(blockfloor) > row[0]:
                return [(f"Wrong input, Floor {blockfloor} does not exist, hospital has {row[0]} floors",),]
    except:
        return [("Error: unable to fetch data",),] 

    sql = f"""select b.BlockCode
            from block b
            where b.BlockFloor = {blockfloor}
            order by b.BlockCode"""

    # Fetch a single row using fetchone() method.
    try:
        # Execute the SQL command
        cur.execute(sql)
        # Fetch all the rows in a list of lists.
        results = cur.fetchall()
        if len(results) == 9:
            return [("result",),] + [("can not create ward,number of wards will exceed 9",),]
    except:
        return [("Error: unable to fetch data",),]

    # Find which blockcode the new block will have 
    blockcode = 1    
    for row in results:
        if blockcode != row[0]:
            break
        blockcode = blockcode + 1

    #insert block
    sql = f"""insert into block(BlockFloor,BlockCode)
            values({blockfloor},{blockcode});"""

    try:
        cur.execute(sql)
        #generate number of rooms from 1-5
        numberofroom = random.randint(1,5)

        #for each generated room
        for i in range(0,numberofroom):
            #make a code for the room
            code = str(blockfloor) + str(blockcode) + "0" + str(i)
            #insert it
            sql = f"""insert into room(RoomNumber,RoomType,BlockFloor,BlockCode,Unavailable)
                values({code},'',{blockfloor},{blockcode},0);"""
            cur.execute(sql)
            con.commit()
    except:
        con.rollback()
    
    return [("result",),] + [("ok",),]

def findnurse(x,y):

    if x.isnumeric() != True or y.isnumeric() != True:
        return [("Wrong input, please try again",),]

    # Create a new connection
    con=connection()
    
    # Create a cursor on the connection
    cur=con.cursor()
    #a query to see how many Floors hospital has
    sql = f"""select count(distinct(BlockFloor))
                from block"""
    try:
        cur.execute(sql)
        results = cur.fetchall()
        for row in results:
            print(row[0])
            if int(x) > row[0]:
                return [(f"Wrong input, Floor {x} does not exist, hospital has {row[0]} floors",),]
    except:
        return [("Error: unable to fetch data",),]
    
    # execute SQL query using execute() method.
    sql = f"""select nu.Name, nu.EmployeeID, count(distinct(p.SSN))
            from vaccination vac,nurse nu, patient p
            where vac.patient_SSN = p.SSN and vac.nurse_EmployeeID = nu.EmployeeID and nu.EmployeeID in (
                select n.EmployeeID
                from nurse n, on_call oc
                where oc.Nurse = n.EmployeeID and oc.BlockFloor = {x}
                group by n.EmployeeID
                having count(distinct(oc.BlockCode)) = (
                    select count(*)
                    from block b
                    where b.BlockFloor = {x})
                and {y} <= (
                    select count(distinct(pa.SSN))
                    from patient pa,appointment a
                    where a.PrepNurse = n.EmployeeID and a.Patient = pa.SSN)
                )
            group by nu.EmployeeID"""

    # Fetch a single row using fetchone() method.
    try:
        # Execute the SQL command
        cur.execute(sql)
       
        # Fetch all the rows in a list of lists.
        mylist = []
        results = cur.fetchall()
        for row in results:
            mylist.append(row)
        
        if len(mylist) == 0:
            return [("No result found with current criteria",),] 
        
        return [("Nurse", "ID", "Number of patients"),] + mylist
    except:
        return [("Error: unable to fetch data",),]

def patientreport(patientName):

    if patientName.isnumeric() == True:
        return [("Wrong input, please try again",),] 
    
    # Create a new connection
    con=connection()

    # Create a cursor on the connection
    cur=con.cursor()

    #a query to see if given patient exist in database
    sql = f"""select *
			    from patient
			    where Name = '{patientName}'"""

    try:
        cur.execute(sql)
        results = cur.fetchall()
        
        if len(results)==0:
            return [("Patient does not exist",),]
    except:
        return [("Error: unable to fetch data",),]

    sql = f"""select p.Name, ph.Name, n.Name, s.StayEnd, t.Name, t.Cost, r.RoomNumber, r.BlockFloor, r.BlockCode
            from patient p, undergoes u, treatment t, physician ph,nurse n,stay s, room r
            where p.Name = '{patientName}' and u.AssistingNurse = n.EmployeeID and ph.EmployeeID = u.Physician and
		        u.Patient = p.SSN and t.Code = u.Treatment and u.Stay = s.StayID and s.Room = r.RoomNumber"""

   # Fetch a single row using fetchone() method.
    try:
        # Execute the SQL command
        cur.execute(sql)
        
        # Fetch all the rows in a list of lists.
        mylist = []
        results = cur.fetchall()
        for row in results:
            mylist.append(row)
        if len(mylist) == 0:
            return [("No result found with current Patient",),] 
        return [("Patient","Physician", "Nurse", "Date of release", "Treatement going on", "Cost", "Room", "Floor", "Block"),] + mylist 
    except:
        return [("Error: unable to fetch data",),]