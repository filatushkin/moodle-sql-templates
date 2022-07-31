select
    gi.id,
    gi.itemname,
    c.fullname as coursename,
    cc.name as category,
    IF(c.visible = 0, 0, IF(cc.visible = 0, 0, 1)) as visible
from
    mdl_course_categories cc
    inner join mdl_course c on c.category = cc.id
    inner join mdl_grade_items gi on (gi.courseid = c.id)
where
    itemtype = 'mod'