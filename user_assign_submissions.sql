select
    subm.id,
    cm.id as cm,
    u.id as userid,
    u.firstname,
    u.lastname,
    u.idnumber as studentid,
    crs.id as courseid,
    crs.idnumber as course,
    subm.attemptnumber,
    asgn.name as assignmentname,
    subm.timemodified,
    #asgn.intro as assignment_text,
    #ast.onlinetext as submission_text,
    IF(asf.numfiles > 0, 'yes', 'no') as hasattach,
    ag.grade as grade
from
    mdl_assign_submission subm
    inner join mdl_assign asgn on (asgn.id = subm.assignment)
    inner join mdl_course crs on (asgn.course = crs.id)
    inner join mdl_user u on (subm.userid = u.id)
    inner join mdl_course_modules cm on (
        cm.instance = asgn.id
        and crs.id = cm.course
    )
    left join mdl_assignsubmission_file asf on (
        asf.assignment = subm.assignment
        and asf.submission = subm.id
    )
    left join mdl_assignsubmission_onlinetext ast on (
        ast.assignment = subm.assignment
        and ast.submission = subm.id
    )
    left join mdl_assign_grades ag on (
        ag.assignment = subm.assignment
        and subm.userid = ag.userid
        and ag.attemptnumber = subm.attemptnumber
    )
where
    subm.status = 'submitted'
    and subm.latest = 1
    and u.id = :userid
    and ast.onlinetext is not null
    and ag.grade <> -1