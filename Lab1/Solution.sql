select paper_title from Paper_details where paper_type="conference";

select * from Student_details where research_area="Big Data";

select count(*) from Paper_details where paper_type="Journal";

SELECT COUNT(*)
FROM Student_details
WHERE DOB BETWEEN '1990-04-01' AND '2000-03-31';

select * from Faculty_details where research_area="AI";

select * from Faculty_details where research_area="AI" or research_area="Big Data";

select * from Student_details where student_name like "%Kumar";

select count(student_id), faculty_id
from Supervisor
group by faculty_id;

select x.author_id, x.paper_id
from Paper_author as x
join(
	select paper_id
	from Paper_author
	group by paper_id
	having count(distinct author_id) > 1
) as y
	on x.paper_id=y.paper_id;
