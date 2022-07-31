SELECT
  ma1.*,
  a.course,
  a.name,
  u.idnumber
FROM
  mdl_assign_grades ma1
  LEFT JOIN mdl_assign_grades ma2 ON ma1.userid = ma2.userid
  AND ma1.assignment = ma2.assignment
  AND ma1.grade < ma2.grade
  inner join mdl_assign a on a.id = ma1.assignment
  inner join mdl_user u on u.id = ma1.userid
  inner join mdl_course c on c.id = a.course
WHERE
  ma2.attemptnumber is NULL