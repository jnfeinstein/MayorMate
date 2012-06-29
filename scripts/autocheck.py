#! /usr/local/bin/python


import sys
import os
import foursquare
import httplib
import sched
import time
import threading

ACCESS_TOKENS = {'jnfeinstein@gmail.com':'4AM3OIMOTPMH3ZKXDKDMUWR4ZP4NYBMJWMODJXU1JCKBZLYT'}

THREADS = {}

# Return the response of a post request
def postUrl(host,url,params,headers):
	conn = httplib.HTTPSConnection(host)
	conn.request("POST",url,params,headers)
	response = conn.getresponse()
	conn.close()
	return response

# Return the response of a get request
def getUrl(host,url):
	conn = httplib.HTTPSConnection(host)
	conn.request("GET",url)
	return conn.getresponse()

def hasAccessToken(user):
     return user in ACCESS_TOKENS
        
def getAccessToken(user):
    # Construct the client object
    client = foursquare.Foursquare(client_id='YTRDZFMWBREGWX4MUUAKUPFDZXU3TUVIWZ3HQY3UGITW1K3Y', client_secret='AKBXY1M3PKL05TR0BHO1BE34W0U5OCWU54OOZZGU5503TMK0', redirect_uri='http://joelf.me')
    
    # Build the authorization url for your app
    auth_uri = client.oauth.auth_url()
    print "Navigate to the following URL and allow mayormate to access your profile"
    print auth_uri
    input_code = raw_input('Enter the code: ')
    access_token = client.oauth.get_token(input_code)
    ACCESS_TOKENS[user] = access_token

def checkin(user,query,ll):
    #print "Checking in " + user + " at " + query + " near " + ll
    client = foursquare.Foursquare(access_token=ACCESS_TOKENS[user])
    venues = client.venues.search(params={'query':query,'ll':ll,'llAcc':'1'})
    venue_id = venues['venues'][0]['id']
    client.checkins.add(params={'venueId':venue_id,'broadcast':'public','ll':ll,'llAcc':'1'})

class CheckinThread(threading.Thread):
    def __init__(self,user,query,ll):
        threading.Thread.__init__(self)
        self.user = user
        self.query = query
        self.ll = ll
        self.schedule = sched.scheduler(time.time, time.sleep)
    
    def run(self):
        self.repeatingCheckin(self.user,self.query,self.ll)

    def repeatingCheckin(self,user,query,ll):
        checkin(user,query,ll)
        #print "Rescheduling and waiting"
        self.scheduleNext(user,query,ll)
    
    def scheduleNext(self,user,query,ll):
        self.schedule.enter(86400,1,self.repeatingCheckin,(user,query,ll))
        self.schedule.run()

    def cancel(self):
        map(self.schedule.cancel,self.schedule.queue)

def cancelRepeating(user,query):
    if not user in THREADS:
        return
    elif not query in THREADS[user]:
        return
    THREADS[user][query].cancel()

def makeRepeating(user,query,ll):
    if not user in THREADS:
        THREADS[user] = {}
    if query in THREADS[user]:
        THREADS[user][query].cancel()
    
    new_thread = CheckinThread(user,query,ll)
    new_thread.setDaemon(True)
    new_thread.start()
    THREADS[user][query] = new_thread

def main(argv):
    
    while True:
        option = raw_input("add(A)/Remove(R)? ")
        if option == "A":
            user = raw_input("Input user: ")
            query = raw_input("Input query: ")
            ll = raw_input("Input lat/long: ")
            if not hasAccessToken(user):
                print "No access token"
                getAccessToken(user)
            #checkin('jnfeinstein@gmail.com','Qualcomm - Bldg BB','32.86,-117.21')
            makeRepeating(user,query,ll)
            print "Added " + user + " with query " + query + " with location " + ll
        elif option == "R":
            user = raw_input("Input user: ")
            query = raw_input("Input query: ")
            cancelRepeating(user,query)
            print "Removed " + user + " with query " + query

if __name__=='__main__':
    main(sys.argv[1:])