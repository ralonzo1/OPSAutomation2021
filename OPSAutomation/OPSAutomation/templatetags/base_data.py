import datetime
from django import template

register = template.Library()

### BASE - HOME ###
@register.simple_tag
def footer_copywright():
    return f"All Rights Reserved 2020 - {datetime.datetime.now().year}"
