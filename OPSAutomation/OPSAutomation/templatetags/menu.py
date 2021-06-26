import datetime
from django import template

register = template.Library()

### BASE - HOME ###
@register.simple_tag
def side_chev():
    return f'<div class="sideChev"><span class="line1"></span><span class="line2"></span></div>'
