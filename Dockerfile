FROM python:3.9-slim-buster
ENV APP_USER devops101
RUN useradd -m -u 1999 $APP_USER
USER $APP_USER
WORKDIR /home/$APP_USER
COPY --chown=$APP_USER:$APP_USER requirements.txt requirements.txt
RUN pip install --user -r requirements.txt
COPY --chown=$APP_USER:$APP_USER . .
RUN pip freeze
EXPOSE 5000
ENTRYPOINT ["python", "calculator.cpython-39.pyc"]