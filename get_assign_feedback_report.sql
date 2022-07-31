select
    ag.id,
    ag.assignment,
    a.name,
    ag.userid,
    u.firstname,
    u.lastname,
    u.idnumber,
    ac.commenttext,
    ac.id as commentid,
    ag.grade,
    ag.timecreated,
    ag.timemodified,
    CONVERT_TZ(
        FROM_UNIXTIME(ag.timecreated),
        '+00:00',
        '+10:00'
    ),
    CONVERT_TZ(
        FROM_UNIXTIME(ag.timemodified),
        '+00:00',
        '+10:00'
    )
from
    mdl_assignfeedback_comments ac
    inner join mdl_assign_grades ag on ag.id = ac.grade
    inner join mdl_assign a on a.id = ag.assignment
    inner join mdl_user u on u.id = ag.userid
where
    ag.grader = :grederid
    and (
        ag.timecreated > :timecreated
        or ag.timemodified > :timemodified
    )