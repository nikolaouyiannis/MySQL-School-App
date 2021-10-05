import mysql.connector
from datetime import date

conn = mysql.connector.connect(host = 'localhost',
                               user = 'root',
                               passwd = 'root',
                               database = 'project_school')

myCursor = conn.cursor()

def menu():
    print("\n", "menu".upper().center(100,'-'), "\n")
    print("[1] Show A list of all the students")
    print("[2] Show A list of all the trainers")
    print("[3] Show A list of all the courses")
    print("[4] Show A list of all the assignments")
    print("[5] Show All the students per course")
    print("[6] Show All the trainers per course")
    print("[7] Show All the assignments per course")
    print("[8] Show All the assignments per course per student")
    print("[9] Insert students")
    print("[10] Insert trainers")
    print("[11] Insert courses")
    print("[12] Insert assignments ")
    print("[13] Insert students per course")
    print("[14] Insert trainers per course")
    print("[15] Insert assignments per student per course")
    print("[0] Exit")

menu()

while True:
    option = int(input("\n>Enter your menu option [0 - 15]: "))
    if option == 1:
        myCursor.execute('SELECT * FROM students')
        for (st_id, fname, lname, bdate) in myCursor:
            print(f"{st_id}: {fname} {lname}, {bdate} \n")

    elif option == 2:
        myCursor.execute('SELECT * FROM trainers')
        for (tr_id, fname, lname) in myCursor:
            print(f"{tr_id}: {fname} {lname} \n")

    elif option == 3:
        myCursor.execute('SELECT * FROM courses')
        for (c_id, c_title, c_lang, c_descr, c_type) in myCursor:
            print(f"{c_id} - {c_title}: {c_lang}, {c_descr}, {c_type} \n")
        
    elif option == 4:
        myCursor.execute('SELECT * FROM assignments')
        for (as_id, c_id, a_descr, deadline) in myCursor:
            print(f"{as_id} - {c_id}: {a_descr}, {deadline} \n")

    elif option == 5:
        myCursor.execute('''SELECT c_language, c_type, first_name, last_name
                        FROM students_per_course spc
                        INNER JOIN students s
                        ON spc.student_id = s.student_id
                        INNER JOIN courses c
                        ON spc.course_id = c.course_id
                        ORDER BY c_language ''')
        for (c_language, c_type, first_name, last_name) in myCursor:
            print(f"{c_language} - {c_type}: {first_name} {last_name} \n")

    elif option == 6:
        myCursor.execute('''SELECT c_language, c_type, first_name, last_name
                        FROM trainers_per_course tpc
                        INNER JOIN trainers t
                        ON tpc.trainer_id = t.trainer_id
                        INNER JOIN courses c
                        ON tpc.course_id = c.course_id
                        ORDER BY c_language ''')
        for (c_language, c_type, first_name, last_name) in myCursor:
            print(f"{c_language} - {c_type}: {first_name} {last_name} \n")

    elif option == 7:
        myCursor.execute('''SELECT c_language, c_type, a_description
                        FROM assignments a
                        INNER JOIN courses c
                        ON a.course_id = c.course_id ''')
        for (c_language, c_type, a_description) in myCursor:
            print(f"{c_language} - {c_type}: {a_description} \n")

    elif option == 8:
        myCursor.execute('''SELECT c_language, first_name, last_name, a_description
                        FROM assignments_per_student_per_course apspc
                        INNER JOIN courses c
                        ON apspc.course_id = c.course_id
                        INNER JOIN students s
                        ON apspc.student_id = s.student_id
                        INNER JOIN assignments a
                        ON apspc.assignment_id = a.assignment_id
                        ORDER BY c_language ''')
        for (c_language, first_name, last_name, a_description) in myCursor:
            print(f"{c_language} : {first_name} {last_name} - {a_description} \n")

    elif option == 9:
        first_name = input("First name: ")
        last_name = input("Last name: ")
        year = int(input("Year of birth: "))
        month = int(input("Month of birth: "))
        day = int(input("Day of birth: "))
        birthdate = date(year, month, day)
        student_data = (first_name, last_name, birthdate)
        st_query = """INSERT INTO students (first_name, last_name, birthdate)
                    VALUES (%s, %s, %s); """
        myCursor.execute(st_query, student_data)
        conn.commit()

    elif option == 10:
        first_name = input("First name: ")
        last_name = input("Last name: ")
        trainer_data = (first_name, last_name)
        tr_query = """INSERT INTO trainers (first_name, last_name)
                    VALUES (%s, %s); """
        myCursor.execute(tr_query, trainer_data)
        conn.commit()

    elif option == 11:
        c_title = input("Course title: ")
        c_language = input("Course language: ")
        c_description = input("Course description: ")
        c_type  = input("Course type: ")
        course_data = (c_title, c_language, c_description, c_type)
        c_query = """INSERT INTO courses (c_title, c_language, c_description, c_type)
                    VALUES (%s, %s, %s, %s); """
        myCursor.execute(c_query, course_data)
        conn.commit()

    elif option == 12:
        print("For which course do you want to add an assignment?\n".upper().center(100, '-'))
        myCursor.execute('''SELECT c.course_id, c_language, c_type, a_description
                        FROM assignments a
                        INNER JOIN courses c
                        ON a.course_id = c.course_id ''')
        for (course_id, c_language, c_type, a_description) in myCursor:
            print(f"course id: {course_id} -> {c_language} - {c_type}: {a_description} \n")
        crs = int(input("Course id: "))
        a_description = input("Assignment description: ")
        year = int(input("Year of assignment deadline: "))
        month = int(input("Month of assignment deadline: "))
        day = int(input("Day of assignment deadline: "))
        deadline = date(year, month, day)
        ass_data = (crs, a_description, deadline)
        ass_query = """INSERT INTO assignments (course_id, a_description, deadline)
                    VALUES (%s, %s, %s); """
        myCursor.execute(ass_query, ass_data)
        conn.commit()

    elif option == 13:
        print("Which student do you want to add to a course?".upper().center(100, '-'))
        myCursor.execute('SELECT * FROM students')
        for (st_id, fname, lname, bdate) in myCursor:
            print(f"{st_id}: {fname} {lname}, {bdate} \n")
        std = int(input("Enter student's id: "))
        print("What course does this student learn?".upper().center(100, '-'))
        myCursor.execute('SELECT * FROM courses')
        for (c_id, c_title, c_lang, c_descr, c_type) in myCursor:
            print(f"{c_id} - {c_title}: {c_lang}, {c_descr}, {c_type} \n")
        crs = int(input("Enter course's id: "))
        year = int(input("Year of enrollment: "))
        month = int(input("Month of enrollment: "))
        day = int(input("Day of enrollment: "))
        enr_date = date(year, month, day)
        data = (std, crs, enr_date)
        query = """INSERT INTO students_per_course (student_id, course_id, enrollment_date)
                    VALUES (%s, %s, %s); """
        myCursor.execute(query, data)
        conn.commit()

    elif option == 14:
        print("Which trainer do you want to add to a course?".upper().center(100, '-'))
        myCursor.execute('SELECT * FROM trainers')
        for (tr_id, fname, lname) in myCursor:
            print(f"{tr_id}: {fname} {lname} \n")
        trn = int(input("Enter trainer's id: "))
        print("What course does this trainer teach?".upper().center(100, '-'))
        for (c_id, c_title, c_lang, c_descr, c_type) in myCursor:
            print(f"{c_id} - {c_title}: {c_lang}, {c_descr}, {c_type} \n")
        crs = int(input("Enter course's id: "))
        data = (trn, crs)
        query = """INSERT INTO trainers_per_course (trainer_id, course_id)
                    VALUES (%s, %s); """
        myCursor.execute(query, data)

    elif option == 15:
        print("For which student do you want to add an assignment?".upper().center(100, '-'))
        myCursor.execute('SELECT * FROM students')
        for (st_id, fname, lname, bdate) in myCursor:
            print(f"{st_id}: {fname} {lname}, {bdate} \n")
        std = int(input("Enter students id: "))
        print("Choose an assignment for the student".upper().center(100, '-'))
        myCursor.execute('SELECT * FROM assignments')
        for (as_id, c_id, a_descr, deadline) in myCursor:
            print(f"{as_id} - {c_id}: {a_descr}, {deadline} \n")
        ass = int(input("Enter assignment's id: "))
        crs = int(input("Enter course's id: "))
        data = (std, crs, ass)
        query = """INSERT INTO assignments_per_student_per_course (student_id, course_id, assignment_id)
                    VALUES (%s, %s, %s); """
        myCursor.execute(query, data)
        conn.commit()

    elif option == 0:
        exit()
        
