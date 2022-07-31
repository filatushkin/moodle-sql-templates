
update
    mdl_course_modules cm
    inner join mdl_course c on c.id = cm.course
    inner join mdl_category cc on cc.id = c.category
set
    cm.availability = NULL
where
    cm.availability is not NULL
    and cc.parent = :categoryid;
