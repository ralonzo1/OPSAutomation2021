FROM python:3.9.2

WORKDIR /src

COPY requirements.txt /root/{{ project }}/requirements.txt
COPY {{ projdir }}_requirements.txt /root/{{ project }}/{{ projdir }}_requirements.txt
COPY scripts/docker_{{ projdir }}.sh /root/{{ project }}/docker_{{ projdir }}.sh
COPY super_user.sh /root/{{ project }}/super_user.sh
COPY .bash_profile /root
#COPY qa/ /root/{{ project }}/qa
COPY .app_list /root/{{ project }}/.app_list
COPY run.sh /root/{{ project }}/run.sh

ENV DJANGO_SUPERUSER_USER={{ django_user }}
ENV DJANGO_SUPERUSER_PASSWORD={{ django_pass }}
ENV DJANGO_SUPERUSER_EMAIL={{ django_email }}
ENV DOCKER_CONTAINER="true"

RUN /bin/bash -c "source /root/.bash_profile \
    && source /root/{{ project }}/docker_{{ projdir }}.sh \
    && clean \
    && install"

EXPOSE 8000

CMD []

ENTRYPOINT [ "/root/{{ project }}/run.sh" ]
