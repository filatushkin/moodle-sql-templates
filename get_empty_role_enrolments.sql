SELECT
    ue.id,
    e.roleid,
    u.id as userid,
    u.idnumber as studentid,
    u.firstname,
    u.lastname,
    c.fullname as course_name,
    c.id as courseid
FROM
    mdl_user_enrolments ue
    INNER JOIN mdl_user u ON u.id = ue.userid
    INNER JOIN mdl_enrol e on e.id = ue.enrolid
    INNER JOIN mdl_course c ON c.id = e.courseid
    INNER JOIN mdl_context ctx ON ctx.instanceid = c.id
    AND ctx.contextlevel = 50
    LEFT JOIN mdl_role_assignments ra ON ra.contextid = ctx.id
WHERE
    ra.id is NULL
    and u.idnumber > 0
order by
    c.id desc