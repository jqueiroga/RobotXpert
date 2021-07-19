import psycopg2
from logging import info

class DeloreanLibrary():

    def connect_database(self):
        return psycopg2.connect(
            host='ec2-18-206-20-102.compute-1.amazonaws.com',
            database='dacb3sq571tvjk',
            user='geqnfmepijowsl',
            password='e7049f0fbcaab4c81f02a912f2af3041f2cfa0731e0a3e342d0086aa12855f71'
        )

    #No RobotFramework esse método virará uma Keyword automaticamente
    #Remove Student s
    def remove_student(self, email):

        query = "delete from students where email = '{}'".format(email)
        info(query)    

        conn = self.connect_database()

        cur = conn.cursor()        
        cur.execute(query)
        conn.commit()
        conn.close()

    def remove_student_by_name(self, name):

        query = "delete from students where name LIKE '%{}%'".format(name)
        info(query)    

        conn = self.connect_database()

        cur = conn.cursor()        
        cur.execute(query)
        conn.commit()
        conn.close()

    
    def insert_student(self, student):
  
        self.remove_student(student['email'])

        query = ("insert into students (name, email, age, weight, feet_tall, created_at, updated_at)"
                "values ('{}', '{}', {}, {}, {}, now(), now());"
                .format(student['name'], student['email'], student['age'], student['weight'], student['feet_tall']))

        info(query)    

        conn = self.connect_database()

        cur = conn.cursor()        
        cur.execute(query)
        conn.commit()
        conn.close()


    def insert_plan(self, plan):
  
        self.remove_plan(plan['title'])

        query =  ("insert into plans (title, duration, price, created_at, updated_at)"
                    "values ('{}', {}, {}, now(), now());"
                    .format(plan['title'], plan['duration'], plan['price']))

        info(query)    

        conn = self.connect_database()

        cur = conn.cursor()        
        cur.execute(query)
        conn.commit()
        conn.close()


    def remove_plan(self, title):

        query = "delete from plans where title = '{}'".format(title)
        info(query)    

        conn = self.connect_database()

        cur = conn.cursor()        
        cur.execute(query)
        conn.commit()
        conn.close()

    def remove_plan_by_term(self, term):

        query = "delete from plans where title LIKE '%{}%'".format(term)
        info(query)    

        conn = self.connect_database()

        cur = conn.cursor()        
        cur.execute(query)
        conn.commit()
        conn.close()