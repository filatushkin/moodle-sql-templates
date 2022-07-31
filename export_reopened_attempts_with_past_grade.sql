select
    ag.id,
    u.idnumber as studentid,
    aa.name,
    DATE_FORMAT(
        convert_tz(
            from_unixtime(ag.timemodified),
            '+00:00',
            '+10:00'
        ),
        '%d-%m-%Y %H:%i:%s'
    ) as gradetime,
    DATE_FORMAT(
        convert_tz(
            from_unixtime(ass.timemodified),
            '+00:00',
            '+10:00'
        ),
        '%d-%m-%Y %H:%i:%s'
    ) as submissiontime,
    cm.id as coursemodule,
    ag.userid,
    ag.grader,
    ag2.attemptnumber as past_attempt,
    ag2.grade as past_grade,
    ass.status,
    ag.attemptnumber as current_attempt,
    ag.grade as current_grade,
    CONCAT(
        "{WebRoot}/mod/assign/view.php?id=",
        cm.id
    ) as link_to_activity
from
    mdl_assign_grades ag
    inner join mdl_assign aa on aa.id = ag.assignment
    inner join mdl_assign_submission ass on (
        ass.assignment = aa.id
        and ass.userid = ag.userid
        and ag.attemptnumber = ass.attemptnumber
    )
    inner join mdl_assign_grades ag2 on (
        ag2.assignment = ag.assignment
        and ag2.userid = ag.userid
        and ag2.attemptnumber = (ag.attemptnumber - 1)
    )
    inner join mdl_course c on c.id = aa.course
    inner join mdl_course_categories cc on cc.id = c.category
    inner join mdl_course_modules cm on (
        cm.instance = aa.id
        and c.id = cm.course
    )
    inner join mdl_user u on u.id = ass.userid
    inner join mdl_user u2 on u2.id = ag.grader
where
    c.visible = 1
    and cc.visible = 1
    and u.idnumber > 0
    and u.suspended = 0
    and u.deleted = 0
    and ass.status = 'reopened'
group by
    ag.id