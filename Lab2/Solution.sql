/*1*/select * from Faculty_details
	where faculty_id not in
	(select faculty_id from Supervisor);

/*2*/select * from Student_details
	where student_institute = 'IIT Patna' and student_id in
	(select author_id from Paper_author);

/*2*/select * from 
	Student_details inner join
		Paper_author on Student_details.student_id=Paper_author.author_id
	where student_institute='IIT Patna';

/*3*/select * from Paper_details
	where paper_id in
	(select paper_id from Paper_author where author_id = '1501CS60');

/*3*/select * from
	Paper_details inner join Paper_author
		on Paper_details.paper_id=Paper_author.paper_id
	inner join Student_details
		on Student_details.student_id=Paper_author.author_id
	where student_id = '1501CS60';

/*4*/select * from Student_details
	where student_id in
	(select student_id from Supervisor where faculty_id='102') and
	student_id in
	(select author_id from Paper_author where paper_id in
		(select paper_id from Paper_details where paper_type='conference'));

/*4*/select * from
	Student_details inner join Supervisor
		on Student_details.student_id=Supervisor.student_id
	inner join Paper_author
		on Student_details.student_id=Paper_author.author_id
	inner join Paper_details
		on Paper_author.paper_id=Paper_details.paper_id
	where faculty_id='102' and paper_type='conference';

/*5*/select paper_title from
	Paper_details inner join Paper_author
		on Paper_details.paper_id=Paper_author.paper_id
	group by Paper_author.paper_id
	having count(author_id)<2;

/*6*/select faculty_id, count(Paper_author.author_id) from
	Faculty_details inner join Paper_author
		on Faculty_details.faculty_id=Paper_author.author_id
	inner join Author_details
		on Paper_author.author_id=Author_details.author_id
	where Author_details.author_type='faculty'
	group by faculty_id;

/*7*/select author_id, count(paper_id) as cn
	from Paper_author
	group by author_id
	order by cn desc
	limit 1;

/*8*/select * from Student_details
	where student_id not in
	(select author_id from Paper_author);

/*9*/select * from Student_details
	where student_id in
	(select student_id
		from Supervisor
		group by student_id
		having count(faculty_id)=2);

/*10*/select count(Paper_author.paper_id)
	from Paper_author inner join Faculty_details
		on Paper_author.author_id=Faculty_details.faculty_id
	where Faculty_details.research_area='Big Data'
	group by author_id;

/*11*/select research_area, count(paper_id) as cn from
	Faculty_details left join Paper_author
		on Faculty_details.faculty_id=Paper_author.author_id
	group by research_area
	order by cn desc;

/*12*/select faculty_name,count(student_id) as cn from
	Faculty_details inner join Supervisor
		on Faculty_details.faculty_id=Supervisor.faculty_id
	group by faculty_name
	order by cn desc
	limit 1;




