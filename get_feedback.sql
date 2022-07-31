select
    *
from
    mdl_feedback_value fv
    inner join mdl_feedback_item fi on fi.id = fv.item
    inner join mdl_feedback f on f.id = fi.feedback
    inner join mdl_course c on c.id = f.course
where
    c.visible = 1
    and fi.template = 0
order by
    fv.id desc